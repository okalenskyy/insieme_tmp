# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A single self-contained HTML file — `insieme_project_dashboard.html` (~1700 lines) — that renders an interactive progress dashboard for the **INSIEME** EU energy project (Pilot & CEEDS Implementation Progress). There is no build system, no package manager, no dependencies, and no tests. CSS lives in one `<style>` block (top), markup in `<body>`, and all logic in one trailing `<script>` block.

## Running

Open the file directly in a browser — there is no server or build step:

```bash
open insieme_project_dashboard.html
```

After editing, reload the browser to see changes.

## Architecture

The dashboard is **data-driven**: large `const` arrays/objects near the top of the `<script>` hold the project model, and `render*()` functions read from them to build the DOM. To change content, edit the data constants — not the generated HTML. Sections are wired to clickable tabs via `data-*` attributes (`data-cluster`, `data-objtab`, `data-heatmode`, `data-bmtab`) whose click handlers call the matching render function.

### Core data model (edit these to change the dashboard)

- `SERVICES` — the 9 CEEDS meta-services (S1–S8 + DCI), each `{id, name, desc}`.
- `DEPLOYMENTS` — the 20 pilots, each `{id, name, cluster, task, partners, services[], phases[], desc, cross}`. `cluster` drives the Gantt tab filter; `phases` are `{p, start, end}` over a 12-quarter (M1–M36) timeline where Q1 = 2025Q2.
- `MATURITY` — nested `{depId: {svcId: 0–5}}` scores backing the Deployment × Service heatmap (0 = not in scope … 5 = pilot operational).
- `CROSSBORDER`, plus pairwise logic in `renderXB()` — the cross-border data-exchange matrix.
- `MILESTONES` — timeline dots, each with an `x` (month 0–36) and `status` (`done`/`current`/`future`).
- `OBJECTIVES` (I-OB), `EOS` (Expected Outcomes), `USECASES` (I-UC), `UC_COVERAGE` — the objectives/outcomes/use-case panel and Pilots × Use-Cases heatmap.
- `PROJECT_KPIS`, `WP_KPIS`, `RISKS`, `MI_GATES` — project KPI tables, per-work-package KPIs, risk register, and go/no-go gates.
- `TNO_*` and `INSIEME_SELF_ASSESS` — WP5 business-model / sustainability case-study content (`data-bmtab`).

### Rendering pattern

Each `render*()` function (`renderGantt`, `renderHeat`, `renderXB`, `renderObjTab`, `renderUC`, `renderMS`, `renderDep`, `renderSvc`, etc.) builds an HTML string from the data, injects it into a container by `id`, then attaches click handlers to drill into a detail panel (`#depDetail`, `#serviceDetail`, `#xbDetail`, `#msDetail`, …). `HEAT_MODE` toggles the service heatmap between maturity scores and binary D4.1 presence.

When adding a pilot or service, update **all** related structures that key off its id (e.g. a new `DEPLOYMENTS` entry should also get `MATURITY` and `UC_COVERAGE` entries), or the matrices will show it as empty/not-in-scope.

## Repository note

The git root is the user's home directory (`/Users/ok`), not this folder — `git status` surfaces many unrelated files. Scope commits to `insieme_project_dashboard.html` (and this file) explicitly.
