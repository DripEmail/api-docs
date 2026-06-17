# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is the Drip API documentation site (developer.drip.com) — a [Slate](https://github.com/lord/slate)-based static site built with Middleman. Content is Markdown; there are no tests or linters.

## Commands

```bash
bundle install                 # install dependencies (Ruby 2.7.6 per .tool-versions)
bundle exec middleman server   # serve locally at http://localhost:4567
bundle exec middleman build    # build static site into build/
script/release                 # deploy main to production (GitHub Pages via middleman-deploy)

ruby script/generate-docs      # regenerate source/includes/rest/_*.md from spec/
ruby script/verify-docs        # check generated md matches the committed partials
npx @redocly/cli preview-docs spec/rest-v2.yaml   # Redoc preview of the REST API
```

## Architecture

All documentation renders into a single page from `source/index.html.md`. That file's YAML frontmatter contains four ordered include lists (`includes_rest_api`, `includes_js_api`, `includes_cdc`, `includes_shopper_activity`), which `source/layouts/layout.erb` iterates to pull in partials from `source/includes/{rest,js,cdc,shopper_activity}/`.

To add a new documentation section: create `source/includes/<group>/_<name>.md` and add `<group>/<name>` to the matching frontmatter list in `source/index.html.md` (order in the list controls order on the page and in the table of contents).

### Content conventions (see any file in `source/includes/rest/` for an example)

- Each partial starts with a `#` heading (resource name) and `##` headings per endpoint.
- Code samples appear in fenced blocks tagged `shell`, `ruby`, or `javascript` — these become the language tabs defined in `index.html.md` frontmatter (`language_tabs`). Provide all three languages for REST endpoints; Ruby examples use the `drip` gem, JavaScript uses `drip-nodejs`.
- Blockquote lines (`> ...`) immediately above code blocks become annotations displayed in the dark code column.
- JSON response examples use ```` ```json ```` blocks; request/response property documentation uses raw HTML `<table>` elements.

### Custom Middleman plumbing (`lib/`)

- `multilang.rb` — tags rendered code blocks so the JS language switcher can toggle them.
- `unique_head.rb` — de-duplicates generated heading anchor IDs.
- `toc_data.rb` — builds the left-nav table of contents from H1/H2/H3 headings.
- `openapi_slate.rb` — converts an OpenAPI resource fragment into a Slate `_*.md` partial (used by `script/generate-docs` / `script/verify-docs`).

### REST docs are migrating to OpenAPI (`spec/`)

The REST partials in `source/includes/rest/` are being moved to a spec-as-source-of-truth model: each resource is described as OpenAPI 3.1 in `spec/fragments/`, **Redoc** renders the aggregator `spec/rest-v2.yaml`, and the custom generator reproduces the existing Slate markdown so the public site is unchanged. See `spec/README.md` for the workflow and the `x-slate` presentation-extension reference.

- Edit the OpenAPI fragment, not the generated `_<resource>.md`, for any resource that has a matching `spec/fragments/<resource>.yaml`. Regenerate with `ruby script/generate-docs <resource>` and verify with `ruby script/verify-docs <resource>`.
- The conceptual partials (`_authentication.md`, `_rate_limiting.md`, `_pagination.md`, `_errors.md`, `_webhook_events.md`) are hand-authored and **not** generated.
- Migration status: all 14 REST resources are generated from `spec/fragments/`. `tags`, `custom_fields`, `accounts`, `users`, `conversions`, `forms`, `events`, `webhooks`, `batch_api`, `campaigns`, `subscribers`, `workflows`, `broadcasts` pass `verify-docs` (NORM); `orders` differs only by incidental blank lines. The larger pages (`subscribers`, `campaigns`, `workflows`, `broadcasts`, `batch_api`) were regenerated as canonical output, so their committed `_*.md` reflects the generator (e.g. full response JSON instead of `{ ... }` placeholders, schema-derived tables). Run `ruby script/verify-docs` for current status.
- Open item: the published Batch API page also documents three **v3 Shopper Activity** batch endpoints (cart/order/product `batch`). These are not part of the `rest-v2` spec; they're currently carried verbatim in `spec/fragments/batch_api.yaml` under `x-slate.footer`. Long term they should move to a dedicated shopper-activity spec and be cross-linked.
