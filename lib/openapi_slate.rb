# frozen_string_literal: true

# OpenAPI -> Slate markdown generator.
#
# Converts a single resource fragment (spec/fragments/<resource>.yaml) into the
# Slate partial the public docs site renders (source/includes/rest/_<resource>.md).
#
# Design:
#   * OpenAPI structural data (paths, schemas, parameters, responses, examples)
#     is the source of truth Redoc reads when bundling spec/rest-v2.yaml.
#   * The `x-slate` vendor extension carries the Slate-only presentation layer
#     (annotation prose, hand-formatted JSON, anomalies in the published docs)
#     that cannot be derived from the structured data alone.
#
# Stdlib only (YAML/Psych + JSON) so it runs under the system Ruby as well as
# the devbox toolchain.

require "yaml"
require "json"

module OpenapiSlate
  # Loads a fragment and resolves $ref pointers, including relative external
  # refs into spec/components.yaml.
  class Loader
    def initialize(path)
      @path = File.expand_path(path)
      @dir = File.dirname(@path)
      @root = self.class.load_yaml(@path)
      @cache = { @path => @root }
    end

    # Parse a trusted local spec file across Ruby/Psych versions. Psych 4 made
    # YAML.load a safe loader (no aliases); these specs are trusted, so prefer
    # the unsafe loader when present to keep anchor/alias support.
    def self.load_yaml(file)
      content = File.read(file)
      if YAML.respond_to?(:unsafe_load)
        YAML.unsafe_load(content)
      else
        YAML.load(content)
      end
    end

    attr_reader :root, :path

    # Resolve a node one level: if it's a {"$ref" => "..."} map, follow it
    # (recursively) and return the target. Otherwise return the node as-is.
    def deref(node)
      return node unless node.is_a?(Hash) && node.key?("$ref")

      deref(resolve_pointer(node["$ref"]))
    end

    private

    def resolve_pointer(ref)
      file_part, _, fragment = ref.partition("#")
      doc = file_part.empty? ? @root : load_file(File.expand_path(file_part, @dir))
      fragment.split("/").reject(&:empty?).reduce(doc) do |acc, raw|
        key = raw.gsub("~1", "/").gsub("~0", "~")
        unless acc.is_a?(Hash) && acc.key?(key)
          raise "Unresolvable $ref #{ref.inspect} (missing segment #{key.inspect})"
        end
        acc[key]
      end
    end

    def load_file(file)
      @cache[file] ||= self.class.load_yaml(file)
    end
  end

  # Builds a JSON example object from a schema when no explicit `example` is
  # provided. Used for resource "representation" blocks.
  class ExampleBuilder
    def initialize(loader)
      @loader = loader
    end

    def build(schema)
      schema = @loader.deref(schema)
      return nil unless schema.is_a?(Hash)
      return schema["example"] if schema.key?("example")

      case schema["type"]
      when "object", nil
        props = schema["properties"]
        return {} unless props.is_a?(Hash)

        props.each_with_object({}) do |(name, sub), acc|
          acc[name] = build(sub)
        end
      when "array"
        [build(schema["items"])].compact
      else
        schema["default"]
      end
    end
  end

  # Renders the Slate markdown for one fragment.
  class Renderer
    def initialize(loader)
      @loader = loader
      @examples = ExampleBuilder.new(loader)
    end

    def render
      spec = @loader.root
      tag = primary_tag(spec)
      slate = tag.fetch("x-slate", {})

      out = +"# #{slate["title"] || tag.fetch("name")}\n"
      lead = slate["lead"] || render_lead(slate)
      out << "\n#{rstrip_block(lead)}\n" if lead

      operations(spec).each do |op|
        out << "\n" << render_operation(op)
      end

      out << "\n#{rstrip_block(slate["footer"])}\n" if slate["footer"]

      normalize_trailing(out)
    end

    private

    # Build the resource lead (representation blocks + Properties table) from
    # structured `x-slate` data, as an alternative to a raw `lead` string:
    #
    #   x-slate:
    #     represent:                     # one or more annotated example blocks
    #       - intro: "X are represented as follows:"
    #         schema: Subscriber         # render the schema's example as JSON
    #       - intro: "All responses ..."
    #         json: |                    # or supply a raw JSON block
    #           { ... }
    #     properties: Subscriber         # render a Properties table from a schema
    def render_lead(slate)
      return nil unless slate["represent"] || slate["properties"] || slate["lead_extra"]

      parts = []
      Array(slate["represent"]).each do |block|
        parts << "> #{block["intro"]}" if block["intro"]
        json = block.key?("json") ? rstrip_block(block["json"]) : pretty_json(schema_example(block["schema"]))
        parts << "```json\n#{json}\n```"
      end

      if slate["properties"]
        rows = direct_property_rows(slate["properties"])
        parts << "**Properties**\n\n#{property_table(rows, "Property")}"
      end

      parts << rstrip_block(slate["lead_extra"]) if slate["lead_extra"]

      parts.join("\n\n")
    end

    def schema_example(name)
      schema = lookup_schema(name)
      schema.key?("example") ? schema["example"] : @examples.build(schema)
    end

    # Rows for a resource Properties table: the named schema's own properties.
    def direct_property_rows(name)
      props = lookup_schema(name)["properties"] || {}
      props.map { |field, sub| { "name" => field, "description" => property_description(sub) } }
    end

    # A property's documented description. An OpenAPI 3.1 `$ref` may carry a
    # sibling `description`; prefer it over the referenced schema's own.
    def property_description(sub)
      return sub["description"] if sub.is_a?(Hash) && sub["description"]

      @loader.deref(sub)["description"]
    end

    def lookup_schema(name)
      schema = @loader.root.dig("components", "schemas", name)
      raise "Fragment #{@loader.path} has no schema #{name.inspect}" unless schema

      @loader.deref(schema)
    end

    # The fragment's first tag drives the H1. Fragments declare exactly one
    # resource group today; if that changes, the generator should grow a
    # resource->tag mapping rather than guessing.
    def primary_tag(spec)
      tags = spec["tags"]
      raise "Fragment #{@loader.path} has no `tags:` entry" unless tags.is_a?(Array) && tags.any?

      tags.first
    end

    # Flatten paths -> operations carrying the HTTP method, templated path, and
    # merged (path + operation) parameters. Operations render in document order
    # unless an `x-slate.order` key overrides it (the published pages sometimes
    # interleave operations from different paths).
    def operations(spec)
      methods = %w[get post put patch delete]
      flat = []
      (spec["paths"] || {}).each do |path, item|
        path_params = item["parameters"] || []
        methods.each do |method|
          op = item[method]
          next unless op

          flat << {
            "method" => method,
            "path" => path,
            "parameters" => path_params + (op["parameters"] || []),
            "op" => op,
            "doc_index" => flat.length,
            "order" => op.fetch("x-slate", {})["order"],
          }
        end
      end
      flat.sort_by { |o| [o["order"] || o["doc_index"], o["doc_index"]] }
    end

    def render_operation(entry)
      op = entry["op"]
      slate = op.fetch("x-slate", {})
      out = +"## #{op.fetch("summary")}\n"

      out << "\n> #{slate["intro"]}\n" if slate["intro"]
      out << "\n" << code_samples(op, slate["code-order"])

      # `response` may be a single block (Hash) or a list of blocks (e.g. a
      # success example followed by documented error examples).
      response_blocks = slate["response"].is_a?(Array) ? slate["response"] : [slate["response"]].compact
      response_blocks.each do |response|
        out << "\n> #{response["intro"]}\n" if response["intro"]
        body = response_body(op, response)
        out << "\n```json\n#{body}\n```\n" if body
      end

      if op["description"] && describe_inline?(slate)
        out << "\n#{collapse(op["description"])}\n"
      end

      out << "\n#{rstrip_block(slate["sections"])}\n" if slate["sections"]

      out << "\n### HTTP Endpoint\n\n`#{endpoint(entry, slate)}`\n"
      out << "\n### Arguments\n\n#{arguments(entry, slate)}\n"
      out
    end

    # The operation description is surfaced as a plain paragraph only when the
    # published doc shows one (opt-in via x-slate.show-description: true), since
    # Redoc already renders `description` in its own panel.
    def describe_inline?(slate)
      slate["show-description"] == true
    end

    # Emit one fenced block per language. Samples render in authored order
    # (deduped by language) unless `x-slate.code-order` lists the languages
    # explicitly, so a resource can present, e.g., Ruby before shell when the
    # published page does.
    def code_samples(op, order = nil)
      samples = op["x-codeSamples"] || []
      seen = {}
      uniq = samples.reject { |s| seen[s["lang"]].tap { seen[s["lang"]] = true } }
      uniq = uniq.sort_by { |s| order.index(s["lang"]) || order.length } if order

      blocks = uniq.map { |s| "```#{s["lang"]}\n#{rstrip_block(s["source"])}\n```" }
      "#{blocks.join("\n\n")}\n"
    end

    def response_body(op, response)
      return rstrip_block(response["body"]) if response.key?("body")

      example =
        if response["status"]
          status_example(op, response["status"])
        else
          success_example(op)
        end
      return nil if example.nil?

      pretty_json(example)
    end

    # The JSON example for a specific response status (e.g. "422").
    def status_example(op, status)
      resp = @loader.deref((op["responses"] || {})[status.to_s])
      content = resp.dig("content", "application/json") if resp.is_a?(Hash)
      return nil unless content

      content.key?("example") ? content["example"] : @examples.build(content["schema"])
    end

    def success_example(op)
      (op["responses"] || {}).each do |status, resp|
        next unless status.to_s.start_with?("2")

        resp = @loader.deref(resp)
        content = resp.dig("content", "application/json") if resp.is_a?(Hash)
        next unless content

        return content["example"] if content.key?("example")

        if content["schema"]
          built = @examples.build(content["schema"])
          return built unless built.nil?
        end
      end
      nil
    end

    def endpoint(entry, slate)
      return slate["endpoint"] if slate["endpoint"]

      path = entry["path"].gsub(/\{(\w+)\}/, ':\1')
      "#{entry["method"].upcase} /v2#{path}"
    end

    def arguments(entry, slate)
      spec = slate.key?("arguments") ? slate["arguments"] : "auto"
      case spec
      when "none", nil, false
        "None."
      when "auto"
        rows = argument_rows(entry)
        rows.empty? ? "None." : property_table(rows, "Key")
      else
        rstrip_block(spec) # raw HTML / markdown override
      end
    end

    # Collect documented inputs: request body object properties plus any query
    # parameters, as {name, description} rows.
    def argument_rows(entry)
      op = entry["op"]
      rows = []

      body = op.dig("requestBody", "content", "application/json", "schema")
      if body
        rows.concat(schema_property_rows(body))
      end

      (entry["parameters"] || []).each do |param|
        param = @loader.deref(param)
        next unless param["in"] == "query"

        rows << { "name" => param["name"], "description" => param["description"] }
      end
      rows
    end

    # Walk an object schema (following a top-level array wrapper, e.g.
    # {events: [Event]}) down to the documented item properties.
    def schema_property_rows(schema)
      schema = @loader.deref(schema)
      return [] unless schema.is_a?(Hash)

      if schema["type"] == "object" && schema["properties"]
        wrapper = schema["properties"].values.map { |v| @loader.deref(v) }
        if wrapper.length == 1 && wrapper.first["type"] == "array"
          return schema_property_rows(wrapper.first["items"])
        end

        return schema["properties"].map do |name, sub|
          { "name" => name, "description" => property_description(sub) }
        end
      elsif schema["type"] == "array"
        return schema_property_rows(schema["items"])
      end
      []
    end

    def property_table(rows, header)
      body = rows.map do |row|
        desc = html_escape_description(row["description"].to_s)
        "    <tr>\n      <td><code>#{row["name"]}</code></td>\n      <td>#{desc}</td>\n    </tr>"
      end.join("\n")

      <<~HTML.rstrip
        <table>
          <thead>
            <tr>
              <th>#{header}</th>
              <th>Description</th>
            </tr>
          </thead>
          <tbody>
        #{body}
          </tbody>
        </table>
      HTML
    end

    # Light markdown->HTML for description cells: `code` -> <code>, and
    # [text](url) -> <a>. Matches the conventions in the published tables.
    def html_escape_description(text)
      text = collapse(text)
      text = text.gsub(/`([^`]+)`/) { "<code>#{Regexp.last_match(1)}</code>" }
      text.gsub(/\[([^\]]+)\]\(([^)]+)\)/) do
        %(<a href="#{Regexp.last_match(2)}">#{Regexp.last_match(1)}</a>)
      end
    end

    # Collapse hard-wrapped YAML block scalars into a single line.
    # JSON.pretty_generate renders an empty container across two lines
    # (`{\n}`); the published docs use the compact `{}` / `[]` form.
    def pretty_json(value)
      JSON.pretty_generate(value).gsub(/\{\n\s*\}/, "{}").gsub(/\[\n\s*\]/, "[]")
    end

    def collapse(text)
      text.to_s.gsub(/\s*\n\s*/, " ").strip
    end

    def rstrip_block(text)
      text.to_s.gsub(/\s+\z/, "")
    end

    def normalize_trailing(out)
      "#{out.gsub(/\n+\z/, "")}\n"
    end
  end

  def self.render_file(path)
    Renderer.new(Loader.new(path)).render
  end
end
