# Drip API Documentation

The source for [developer.drip.com](https://developer.drip.com). A [Slate](https://github.com/lord/slate)-derived
[Middleman](https://middlemanapp.com/) site: every page is Markdown under `source/includes/`,
rendered into a single-page HTML document.

## Getting started

```bash
nix develop     # ruby, node, and the rest of the toolchain
make serve      # http://localhost:4567
```

`make serve` live-reloads as you edit. To check the artifact that actually ships:

```bash
make preview    # builds, then serves build/ on http://localhost:4568
```

Run `make` on its own to list every target.

## Editing the docs

Content lives in `source/includes/`, one Markdown file per topic. `source/index.html.md`
is the manifest: its front matter lists the includes, in order, under the section they
belong to (`includes_rest_api`, `includes_js_api`, `includes_cdc`,
`includes_shopper_activity`).

To add a REST topic:

1. Write `source/includes/rest/_your_topic.md`, starting with an `# H1` title.
2. Add `- rest/your_topic` to `includes_rest_api` in `source/index.html.md`.

Headings drive the sidebar: the `H1` becomes a top-level entry and each `H2` a child.
Anchors are generated from the heading text.

Conventions worth matching when you write a new topic — copy an existing file rather
than inventing:

- Blockquoted lines (`> To fetch a workflow:`) become the annotation above a code sample.
- Consecutive ` ```shell `, ` ```ruby `, ` ```javascript ` blocks render as language tabs.
  The tabs are the ones declared in `language_tabs` in `source/index.html.md`.
- Endpoints are documented as `### HTTP Endpoint` followed by `### Arguments`, with
  arguments in a raw `<table>` rather than a Markdown table.
- Property and argument descriptions lead with `Required.` or `Optional.`

Markdown is rendered by **redcarpet**, not kramdown or CommonMark. Three helpers in
`lib/` shape the output:

| File | Role |
| --- | --- |
| `unique_head.rb` | Generates deduplicated `id` attributes on headings |
| `toc_data.rb` | Parses the rendered HTML to build the sidebar |
| `multilang.rb` | Adds the `tab-<lang>` classes that drive language tabs |

## Toolchain

`flake.nix` pins everything — Ruby, Node, and the native libraries the gems compile
against. Two shells share one definition:

- `nix develop` — the full developer environment
- `nix develop .#ci` — build dependencies only; what CI uses

Gems install into `vendor/bundle` inside the checkout, never into your user profile.

Without Nix you need Ruby (the version `flake.nix` pins), Node, and a C toolchain, then
`bundle install`. The Nix shell is the supported path; everything else is on you.

## CI

`.github/workflows/ci.yml` runs `nix develop .#ci --command make check` on every pull
request — the same command you can run locally. A successful run uploads the built site
as a `site` artifact, which is the easiest way to review a rendering change on a PR.

There are no tests. "Green" means the site builds.

## Deploying

Deploys are manual, from a checkout:

```bash
make deploy
```

This builds and pushes the result to the `gh-pages` branch, which GitHub Pages serves at
`developer.drip.com` (via `source/CNAME`). Deploy from `main`, after CI is green.
