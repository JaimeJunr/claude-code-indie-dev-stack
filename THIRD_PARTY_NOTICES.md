# Third-party notices

Everything under `plugins/` except `plugins/indie-dev-stack` comes from
https://github.com/anthropics/knowledge-work-plugins (Apache-2.0, copy in each
plugin's `LICENSE`), by Anthropic. Pinned commit: see `UPSTREAM.lock`.

Modifications:

- The `.mcp.json` connector config of each plugin is removed.
- The `description` frontmatter of the skills listed in
  `patches/descriptions.json` gets a routing hint appended, so overlapping
  skills say which one to use. Bodies are copied verbatim.

`plugins/indie-dev-stack` (the router), `scripts/` and the docs are MIT, see
[LICENSE-MIT](LICENSE-MIT).
