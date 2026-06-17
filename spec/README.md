# REST API spec (OpenAPI source of truth)

The Drip REST API is described as OpenAPI 3.1 in this directory. The spec is the
**source of truth**; the public Slate docs at `source/includes/rest/_*.md` are
**generated** from it. Two renderers consume the same spec:

- **Redoc** renders the whole API from the aggregator `rest-v2.yaml` (default
  OpenAPI viewer).
- **The custom generator** (`script/generate-docs`) renders each fragment into
  the Slate markdown partial the public docs site (developer.drip.com) ships,
  so the published docs stay byte-for-byte the same during the migration.

## Layout

```
spec/
  rest-v2.yaml        # aggregator: info + servers + security + tags, $refs every path
  components.yaml     # shared parameters / responses / schemas / securitySchemes
  fragments/          # one file per resource (Tags, Accounts, …)
    tags.yaml
    accounts.yaml
    ...
```

Each fragment is self-contained: it declares its `tags`, `paths`, and any
resource-specific `components.schemas`, and references shared pieces via a
relative pointer such as `$ref: "../components.yaml#/components/responses/Error"`.
That keeps a fragment renderable on its own by the generator while still
bundling cleanly into `rest-v2.yaml` for Redoc.

## Commands

```bash
# Redoc (default renderer)
npx @redocly/cli preview-docs spec/rest-v2.yaml          # live preview
npx @redocly/cli lint spec/rest-v2.yaml                  # validate
npx @redocly/cli bundle spec/rest-v2.yaml -o out.yaml    # single-file bundle

# Slate markdown generation
ruby script/generate-docs                # regenerate every source/includes/rest/_*.md
ruby script/generate-docs tags users     # regenerate only named resources
ruby script/verify-docs                  # check generated output matches committed md
ruby script/verify-docs --diff tags      # show a unified diff for mismatches
```

`script/verify-docs` reports two results per resource:

- **BYTE** — generated output is byte-identical to the committed `_<resource>.md`.
- **NORM** — output matches after collapsing insignificant whitespace.

NORM is the gate (non-zero exit on failure). BYTE failures are reported but do
not fail the run, because a handful of published pages contain intentional
hand-formatting (and a few historical typos/whitespace quirks) that the spec
deliberately does not reproduce.

## The `x-slate` presentation layer

OpenAPI structural data (paths, parameters, schemas, responses, examples,
`x-codeSamples`) is what Redoc renders. The Slate pages additionally carry prose
and formatting that cannot be derived from that structure — intro annotations,
hand-formatted JSON, resource overview blocks. Those live under the `x-slate`
vendor extension and are consumed only by the generator (Redoc ignores unknown
`x-` keys).

On a **tag** (resource) object, under `x-slate`:

| Key      | Effect |
| -------- | ------ |
| `title`  | Override the `# …` H1 text (e.g. "Orders (Legacy)" where it differs from the Redoc tag name). |
| `lead`   | Raw markdown inserted right after the H1 (the representation JSON + Properties table, intro asides, etc.). |
| `represent` | Structured alternative to a raw `lead`: a list of annotated example blocks, each `{intro, schema}` (renders the schema's example as JSON) or `{intro, json}` (raw JSON). |
| `properties` | Render a **Properties** table from a named schema's properties (used with `represent`). |
| `lead_extra` | Raw markdown appended after the auto-generated `represent`/`properties` lead (e.g. a conceptual sub-section like "Email Content"). |
| `footer` | Raw markdown appended after the last operation (e.g. an "Order events" reference table). |

On an **operation** object, under `x-slate`:

| Key                | Effect |
| ------------------ | ------ |
| `order`            | Integer sort key to reorder operations on the page (the published pages sometimes interleave operations from different paths). Defaults to document order. |
| `code-order`       | List of languages to order the code-sample tabs (e.g. `[ruby, shell]`). Defaults to authored order. |
| `intro`            | Text for the `> …` annotation above the request code samples. |
| `response.intro`   | Text for the `> …` annotation above the response block. |
| `response.body`    | Raw JSON for the response block. Omit to derive it from the response `example` (pretty-printed). Use this for the intentionally hand-formatted/abbreviated bodies (`{ ... }`, compact arrays). |
| `response.status`  | Render the example for a specific response status (e.g. `"422"`) instead of the default success example. |
| `response` (list)  | `response` may also be a list of blocks, to show a success example followed by documented error examples. Each item takes `intro`, plus `status` or `body`. |
| `sections`         | Raw markdown inserted after the response block and before `### HTTP Endpoint` (e.g. an extra Properties table). |
| `endpoint`         | Override the `### HTTP Endpoint` line. Omit to derive `METHOD /v2/<path>` with `{param}` → `:param`. |
| `arguments`        | `none` (→ "None."), `auto` (derive a Key/Description table from the request body / query params), or a raw HTML/markdown string. Defaults to `auto`. |
| `show-description` | `true` to also surface the operation `description` as an inline paragraph (Redoc shows it in its own panel regardless). |

Language tabs render in the order the `x-codeSamples` entries are authored
(deduped by language), so author them shell → ruby → javascript except where a
published page differs (e.g. Orders lists Ruby before shell).

### Adding or changing an endpoint

1. Edit the resource fragment in `spec/fragments/` (structural data first).
2. Add/adjust `x-slate` keys to match the desired Slate page.
3. `ruby script/generate-docs <resource>` and review the diff.
4. `ruby script/verify-docs <resource>` until NORM passes (BYTE if you need
   exact parity with an existing published page).
5. `npx @redocly/cli lint spec/rest-v2.yaml` to confirm the aggregator is valid.

To add a brand-new resource, also add its tag (in display order) and its paths
to `rest-v2.yaml`, and add `<resource>` to `includes_rest_api` in
`source/index.html.md`.
