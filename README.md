# Claude Code Indie Dev Stack

The Claude Code stack for developers who build their own projects and products:
engineering, product, positioning, data and running the business, all in one
marketplace. Anthropic's `product-management`, `engineering`, `small-business` and `data`
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

- **indie-dev-stack** (the glue, useful once you install two or more of the others): a router skill
  that picks the lead skill when plugins overlap, and four agents for a solo
  builder's loop: `product-shaper` (idea to build brief), `ship-check` (is this
  ready to ship), `weekly-review` (product and business, three actions for the
  week), `launch-planner` (release plan and announcement). None of them deploys,
  posts, sends or pays. It also carries written rulings in
  [conflicts.md](plugins/indie-dev-stack/skills/indie-dev-stack/references/conflicts.md).
  The skills that used to compete for the same prompt (research synthesis,
  metrics review, business snapshot, dashboards) also carry a one-line hint in
  their description, see `patches/descriptions.json`.

- **product-management**: write-spec, roadmap-update, sprint-planning, metrics-review,
  competitive-brief, stakeholder-update, synthesize-research, product-brainstorming, `/brainstorm`
- **engineering**: architecture, code-review, debug, deploy-checklist, documentation,
  incident-response, standup, system-design, tech-debt, testing-strategy
- **product-positioning** (from [phuryn/pm-skills](https://github.com/phuryn/pm-skills), MIT): product-vision,
  value-proposition, positioning-ideas, user-personas. Who the product is for and why it wins; the
  result goes to `PRODUCT.md`
- **small-business**, **data**: see each plugin's README under `plugins/`

Screens, UX copy and UX research live in the companion
[frontend stack](https://github.com/JaimeJunr/claude-code-frontend-skills) (it also syncs
Anthropic's design skills). Each router points to the other when a request belongs there.

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

The Action opens that PR with the `SYNC_TOKEN` secret, a fine-grained token
with Contents and Pull requests write access to the repo. Without it, the PR
is opened with the default token, which does not trigger CI, so `validate`
never runs on the sync PR.

## License

Anthropic's plugins: Apache-2.0 (`LICENSE`). The glue plugin, scripts and docs: MIT
(`LICENSE-MIT`). Details in [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).
