# Claude Code Product & Engineering Stack

Anthropic's `product-management`, `engineering`, `small-business`, `legal`, `design` and `data`
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
/plugin marketplace add JaimeJunr/claude-code-product-eng-stack
```

Each plugin is optional. Pick with the `/plugin` menu (Discover tab), or from a
terminal with a checklist:

```bash
scripts/install.sh          # checklist (whiptail)
scripts/install.sh --all    # everything
```

Or one by one:

```
/plugin install engineering@product-eng-stack
```

## What you get

- **product-management**: write-spec, roadmap-update, sprint-planning, metrics-review,
  competitive-brief, stakeholder-update, synthesize-research, product-brainstorming, `/brainstorm`
- **engineering**: architecture, code-review, debug, deploy-checklist, documentation,
  incident-response, standup, system-design, tech-debt, testing-strategy
- **small-business**, **legal**, **design**, **data**: see each plugin's README under `plugins/`

Skills still contain `~~category` placeholders (for example `~~project tracker`).
Without a connector, Claude asks you to paste the data instead. `CONNECTORS.md`
is kept because the skills link to it.

## Keeping it in sync

```
scripts/sync.sh [ref]
```

Re-clones upstream, copies the plugins, deletes `.mcp.json`, regenerates the
marketplace manifest and `UPSTREAM.lock`. A GitHub Action does this every Monday
and opens a PR; another one validates every PR and fails if a `.mcp.json` shows up.

## License

Plugin content: Apache-2.0, by Anthropic (see [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md)).
