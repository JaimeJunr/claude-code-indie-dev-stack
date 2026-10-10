# Third-party notices

`plugins/product-positioning/skills` comes from https://github.com/phuryn/pm-skills
(MIT, copy in `plugins/product-positioning/LICENSE`), by Paweł Huryn, copied
verbatim. Pinned commit: see `UPSTREAM.lock`.

Everything else under `plugins/` except `plugins/indie-dev-stack` comes from
https://github.com/anthropics/knowledge-work-plugins (Apache-2.0, copy in each
plugin's `LICENSE`), by Anthropic. Pinned commit: see `UPSTREAM.lock`.

Modifications:

- The `.mcp.json` connector config of each plugin is removed.
- The `description` frontmatter of the skills listed in
  `patches/descriptions.json` gets a routing hint appended, so overlapping
  skills say which one to use. Bodies are copied verbatim.

`plugins/indie-dev-stack` (the router), `scripts/` and the docs are MIT, see
[LICENSE-MIT](LICENSE-MIT).
