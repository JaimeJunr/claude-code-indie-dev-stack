# Claude Code Product & Engineering Stack

Anthropic's [`product-management`](https://github.com/anthropics/knowledge-work-plugins/tree/main/product-management)
and [`engineering`](https://github.com/anthropics/knowledge-work-plugins/tree/main/engineering)
plugins from `knowledge-work-plugins`, **without the MCP connectors**.

The upstream plugins ship `.mcp.json` files that register about 19 servers
(Asana, Linear, Notion, Figma, Amplitude, Pendo, Intercom, Datadog, PagerDuty,
GitHub, Slack and others). Each one shows up as "needs login" in Claude Code.
Here the servers are removed, so you only get the skills and commands, which
all work standalone.

## Install

```
/plugin marketplace add JaimeJunr/claude-code-product-eng-stack
/plugin install product-management@product-eng-stack
/plugin install engineering@product-eng-stack
```

## What you get

- **product-management**: write-spec, roadmap-update, sprint-planning, metrics-review,
  competitive-brief, stakeholder-update, synthesize-research, product-brainstorming, `/brainstorm`
- **engineering**: architecture, code-review, debug, deploy-checklist, documentation,
  incident-response, standup, system-design, tech-debt, testing-strategy

Skills still contain `~~category` placeholders (for example `~~project tracker`).
Without a connector, Claude asks you to paste the data instead. `CONNECTORS.md`
is kept because the skills link to it.

## Keeping it in sync

```
scripts/sync.sh [ref]
```

Re-clones upstream, copies both plugins, deletes `.mcp.json` and rewrites
`UPSTREAM.lock`.

## License

Plugin content: Apache-2.0, by Anthropic (see [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md)).
