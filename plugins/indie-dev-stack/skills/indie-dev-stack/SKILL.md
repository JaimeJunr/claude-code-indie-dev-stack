---
name: indie-dev-stack
description: Router for the indie dev stack. Use when a request could fit more than one installed plugin (product-management, engineering, design, data, small-business), for example synthesizing interviews, reviewing metrics, building a dashboard, writing a status update or a business snapshot, and when two skills give different advice. Decides which skill leads.
---

# Indie Dev Stack router

The user is a developer who builds their own products and also runs the
business around them. Five plugins are installed side by side, each written
for a different kind of team. This skill decides who leads when more than one
fits, so the agent loads one lead skill instead of two that overlap.

Only route among plugins that are actually installed. If the lead is missing,
use the next row or answer without a skill.

## 1. Read the project first

Look for what the repo already decided before picking anything: `README`,
`docs/`, a roadmap or PRD file, a `DESIGN.md` or design tokens, an existing
schema or analytics setup. These outrank any skill's defaults.

## 2. Pick the lead skill

| The task is... | Lead | Support |
|---|---|---|
| Turn interview notes, survey answers or feedback into decisions about **what to build** | `product-management:synthesize-research` | - |
| Same input, but the question is about **usability, UX or a design decision** | `design:research-synthesis` | `design:user-research` |
| Weekly or monthly review of **product** metrics (usage, activation, retention, funnel) | `product-management:metrics-review` | `data:analyze` for the queries |
| Snapshot of the **business**: cash, sales, pipeline, what needs attention | `small-business:business-pulse` | - |
| "Is growth working?": channels, campaigns, conversion, best products | `small-business:growth-pulse` | - |
| A question that needs SQL or a dataset explored | `data:analyze` / `data:sql-queries` / `data:explore-data` | - |
| A shareable dashboard or chart from data | `data:build-dashboard` / `data:create-viz` | - |
| A recurring report of business numbers, saved and rerun | `small-business:report-builder` | - |
| Status update for investors, users or a team | `product-management:stakeholder-update` | - |
| Daily update from commits, PRs and tickets | `engineering:standup` | - |
| Monday briefing of the week ahead | `small-business:monday-brief` | - |
| Feature spec or PRD | `product-management:write-spec` | `engineering:architecture` once decided |
| Roadmap, sprint plan | `product-management:roadmap-update` / `sprint-planning` | - |
| Architecture decision, system design, tech debt, incident, deploy | `engineering:*` | - |
| Critique a screen, design system, UX copy, accessibility | `design:*` | - |
| Design handoff spec for implementation | `design:design-handoff` | `engineering:documentation` |
| Contract, invoice, payroll, tax, proposals, hiring, leads | `small-business:*` (start at `smb-router` if unsure) | - |

## 3. Precedence ladder

When two loaded skills disagree, the higher rule wins:

1. **The user's explicit request.**
2. **What the project already has.** Existing metrics definitions, schema,
   design tokens, roadmap format. Extend them.
3. **Who the output is for.** An investor, a user, a teammate and yourself need
   different updates; pick the skill built for that reader.
4. **Domain owner.** Product decisions to `product-management`, code and
   operations to `engineering`, screens to `design`, numbers from a warehouse to
   `data`, money and customers to `small-business`.
5. **The lead skill's own defaults.**

Detailed rulings for each overlap are in
[references/conflicts.md](references/conflicts.md). Read it when a supporting
skill contradicts the lead.

## 4. Load budget

One lead skill, at most one supporting. If a request needs three, split it and
run them in sequence, telling the user which skill handles each step.
