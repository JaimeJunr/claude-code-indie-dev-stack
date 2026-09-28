# Where the plugins overlap

Each entry names the overlapping skills and the ruling the stack applies.
Rulings follow the precedence ladder in `../SKILL.md`.

## Research synthesis

- `product-management:synthesize-research` ends in roadmap recommendations.
- `design:research-synthesis` covers usability tests and NPS and points to
  `design:user-research`.
- **Ruling:** decide by the question. "What should we build or prioritize" goes
  to product-management. "Why do people struggle with this screen" goes to
  design. If both questions are open, run product-management first and hand its
  themes to design for the UX follow-up.

## Metrics and reports

- `product-management:metrics-review` reviews product metrics against targets.
- `small-business:business-pulse` and `growth-pulse` read cash, sales and
  pipeline from connected tools.
- `small-business:report-builder` saves and reruns a recurring report.
- `data:analyze` and `data:build-dashboard` work on a dataset or SQL.
- **Ruling:** the subject picks the skill. Users, activation and retention go to
  metrics-review. Money and customers go to business-pulse or growth-pulse.
  Anything that starts from a query or file goes to data. Use report-builder
  only when the user wants the same report to repeat. Data skills may support any
  of these for the queries; they never lead a business snapshot.

## Status updates

- `product-management:stakeholder-update`: audience-tailored progress, launches
  and risks.
- `engineering:standup`: yesterday, today, blockers, built from commits and PRs.
- `small-business:monday-brief`: business snapshot plus the week ahead.
- **Ruling:** by reader. Investors, users or leadership get stakeholder-update.
  The team gets standup. The owner gets monday-brief. A launch note for users is
  stakeholder-update with the customer-facing version.

## Connectors are not installed

These plugins were written to call connected tools (issue trackers, CRMs,
ledgers). Here the connectors are stripped, so skills with `~~placeholders`
ask for pasted data or files. Do not pretend to have pulled data you were not
given, and do not tell the user to authenticate a connector that this stack
does not ship.
