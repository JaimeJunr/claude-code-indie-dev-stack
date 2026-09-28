# Claude Code Indie Dev Stack

The Claude Code stack for developers who build their own projects and products:
engineering, product, design, data and running the business, all in one
marketplace. Anthropic's `product-management`, `engineering`, `small-business`, `design` and `data`
plugins from [`knowledge-work-plugins`](https://github.com/anthropics/knowledge-work-plugins),
each one optional, **without the MCP connectors**.

The upstream plugins ship `.mcp.json` files that register dozens of servers
(Asana, Linear, Notion, Figma, Amplitude, Datadog, PagerDuty, GitHub, Slack and others).
Each one shows up as "needs login" in Claude Code.
Here the servers are removed, so you only get the skills and commands, which
all work standalone.

## Install

Add the marketplace in Claude Code:

```
/plugin marketplace add JaimeJunr/claude-code-indie-dev-stack
```

Each plugin is optional. Pick with the `/plugin` menu (Discover tab), or from a
terminal with a checklist:

```bash
scripts/install.sh          # checklist (whiptail)
scripts/install.sh --all    # everything
```

Or one by one:

```
/plugin install engineering@indie-dev-stack
```

## What you get

- **indie-dev-stack** (the glue, install it with any two or more): a router skill
  that picks the lead skill when plugins overlap, plus written rulings in
  [conflicts.md](plugins/indie-dev-stack/skills/indie-dev-stack/references/conflicts.md).
  The skills that used to compete for the same prompt (research synthesis,
  metrics review, business snapshot, dashboards) also carry a one-line hint in
  their description, see `patches/descriptions.json`.

- **product-management**: write-spec, roadmap-update, sprint-planning, metrics-review,
  competitive-brief, stakeholder-update, synthesize-research, product-brainstorming, `/brainstorm`
- **engineering**: architecture, code-review, debug, deploy-checklist, documentation,
  incident-response, standup, system-design, tech-debt, testing-strategy
- **small-business**, **design**, **data**: see each plugin's README under `plugins/`

Skills still contain `~~category` placeholders (for example `~~project tracker`).
Without a connector, Claude asks you to paste the data instead. `CONNECTORS.md`
is kept because the skills link to it.

## Left out on purpose

`legal` is not included. It reviews contracts against an in-house negotiation
playbook, which solo developers do not have, and it overlaps with
`small-business:contract-review`. To add it back, append `legal` to `PLUGINS` in
`scripts/sync.sh` and run it.

## Keeping it in sync

```
scripts/sync.sh [ref]
```

Re-clones upstream, copies the plugins, deletes `.mcp.json`, applies
`patches/descriptions.json`, regenerates the marketplace manifest and
`UPSTREAM.lock`. The glue plugin is ours and is never overwritten. A GitHub Action does this every Monday
and opens a PR; another one validates every PR and fails if a `.mcp.json` shows up.

## License

Anthropic's plugins: Apache-2.0 (`LICENSE`). The glue plugin, scripts and docs: MIT
(`LICENSE-MIT`). Details in [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).
