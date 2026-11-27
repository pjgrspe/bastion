---
name: anti-slop-engineering
description: >-
  Deterministic engineering guardrails and verification workflows inspired by
  "All Code Is Slop (Except Mine)" (Lauren Tan / pstack). Use when bootstrapping
  a new project, hardening an existing codebase, converting an agent mistake into
  a permanent lint/type/architecture constraint, or executing a strict
  reproduce-and-verify coding loop.
---

# Anti-Slop Engineering Playbook

This skill encodes a deterministic, evidence-first engineering workflow that works identically across Antigravity, Claude Code, Cursor, Codex, and other coding agents.

**Core idea:** Human review does not scale with agent output. Build a self-enforcing environment where bad patterns fail mechanically, and prove every change works with runtime evidence.

---

## Choose Your Mode

Identify which workflow matches the current request and execute its steps in order:

1. **Mode A — Bootstrap a New Project:** Setting up guardrails from Day 1.
2. **Mode B — Harden an Existing Project:** Adding guardrails incrementally without breaking legacy code.
3. **Mode C — Daily Task & Bug-Fix Loop ("Prove It Works"):** Executing feature work or bug fixes with empirical verification.
4. **Mode D — Mistake → Permanent Constraint:** Turning any bug, review comment, or agent mistake into an automated guardrail.

For stack-specific configs (TypeScript/React/Node, Python, etc.), read [references/stack-guardrails.md](./references/stack-guardrails.md).

---

## Mode A: Bootstrap a New Project

1. **Establish a single `verify` command** (e.g., `npm run verify`, `make verify`, or `just verify`) that runs in one step:
   - Static typecheck (strict mode)
   - Linter & formatter check
   - Automated tests
   - Production build
2. **Enable strict typing from Day 1:** Ban implicit `any`, unchecked nulls, and silent type escapes.
3. **Define clean layer boundaries early:**
   - Separate low-level primitives (`core/` or `lib/`) from domain logic (`domain/` or `services/`) and presentation/entry points (`ui/`, `api/`, `cli/`).
   - Enforce import direction mechanically with a linter/boundary checker so higher layers cannot reach into forbidden internals and core layers never import feature code.
4. **Quarantine nuance-heavy APIs:**
   - Wrap error-prone primitives (e.g., React `useEffect`, raw SQL, direct `fetch`, raw env vars) in small, well-tested helpers in `core/` and lint-ban direct usage in product/feature folders.
5. **Validate the gate:** Run the `verify` command and intentionally break one rule (e.g., a type error or banned import) to confirm the gate catches it, then revert the test break.

---

## Mode B: Harden an Existing Project (Incremental Ratchet)

Never try to rewrite an entire legacy codebase at once. Ratchet quality upward without blocking delivery:

1. **Baseline first:** Inspect existing tooling (`package.json`, `pyproject.toml`, CI workflows, linters, tests) and identify what currently runs.
2. **Create a unified `verify` script:** Wire existing typecheck, lint, test, and build commands into one command so every agent has a single source of truth.
3. **Audit top slop / footgun hotspots:** Check git history (reverts, hotfixes, bug-fix commits) or common pain points to find the top 3–5 recurring failure modes.
4. **Apply strict rules to *new and touched code* first:**
   - Add architectural boundary rules and banned-API lint rules, using targeted overrides/baselines for legacy files so existing debt does not block strict enforcement on new code.
   - Add `TODO(guardrail)` or baseline lists only where strictly needed—never disable rules globally.
5. **Document only the non-obvious invariants in `AGENTS.md`:** Keep `AGENTS.md` under ~100 lines. Anything enforceable by a linter or compiler belongs in config, not prose.
6. **Verify:** Run the full `verify` command and confirm it passes cleanly.

---

## Mode C: Daily Task & Bug-Fix Loop ("Prove It Works")

Follow this sequence for every code change:

1. **Understand before editing:** Read the relevant files and existing conventions. Do not guess APIs or duplicate utilities that already exist.
2. **Reproduce first (for bugs):**
   - Create a failing test or minimal command that reliably reproduces the issue.
   - Confirm it fails for the expected reason before changing production code.
3. **Sequence into small slices:**
   - For multi-file or architectural tasks, break work into small steps that leave the repo green after each step.
4. **Implement the root-cause fix:**
   - Avoid band-aids (broad `try/catch`, arbitrary `setTimeout`, `@ts-ignore`, `# type: ignore`, or disabling lint rules).
   - Keep diffs tight and focused on the task.
5. **Verify deterministically + empirically:**
   - Run the project's `verify` command (typecheck + lint + tests + build).
   - Exercise the real changed behavior (run the CLI, hit the endpoint, or inspect the rendered UI).
6. **Report verification artifacts:**
   - In your final summary, list the exact commands run and observed results (pass/fail counts, runtime output, or screenshots) so the human reviews *evidence*, not just code.

---

## Mode D: Mistake → Permanent Constraint

Whenever a bug escapes, a PR is reverted, or an agent repeats an error, climb *down* the Trust Pyramid to the strongest mechanical layer that can catch it:

| Failure Type | Wrong Fix (Weak) | Right Fix (Permanent Constraint) |
| :--- | :--- | :--- |
| Wrong data shape / missing null check | "Remember to check for null" in `AGENTS.md` | Strict type, branded type, or runtime schema validation (Zod/Pydantic) |
| Bad API usage (e.g., raw `useEffect`, raw SQL, `console.log`) | Code review comment | Custom lint rule (`no-restricted-syntax` / `no-restricted-imports` / Ruff rule) |
| Cross-layer spaghetti import | Diagram in README | Automated dependency boundary check (`dependency-cruiser` / `import-linter`) |
| State-machine / concurrency bug | One hardcoded happy-path unit test | Property-based test, state-transition invariant test, or formal spec (TLA+/Lean for critical systems) |
| Pure judgment / product convention | Lint rule that causes false positives | Short, crisp bullet in `AGENTS.md` (last resort) |

**Checklist for Mode D:**
1. Identify the root cause of the mistake.
2. Add the smallest mechanical check (type, lint rule, boundary rule, or regression test) that would have caught it automatically.
3. Confirm the new check fails against the broken pattern and passes against the fixed code.
4. Keep the diff clean and run `verify`.
