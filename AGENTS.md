# Engineering Rules (Bastion Standard)

Applies to all coding agents (Antigravity, Claude Code, Cursor, Codex).

## Trust Pyramid (Strict Order)
1. **Types/Schemas** — make invalid states unrepresentable.
2. **Linters/Boundaries** — ban footgun APIs and illegal imports mechanically.
3. **Tests/Runtime Verification** — prove behavior empirically.
4. **Prose (`AGENTS.md`)** — last resort for pure judgment calls.

## Core Principles
- **Prove It Works:** Run real checks (tests, CLI, API, or UI). Never claim done without empirical evidence.
- **Reproduce First:** For bugs, create a failing test/repro before fixing, then verify it passes.
- **Root Causes Only:** No band-aids, silent `catch`, retries, `any`, or lint disables.
- **Mistake → Constraint:** Turn repeatable mistakes into a type, lint rule, boundary check, or regression test.
- **Small Slices & Behavioral Tests:** Ship verifiable increments; assert observable behavior, not internals.
- **Isolate Nuance-Heavy APIs:** Keep `useEffect`, raw SQL, unvalidated `fetch`, raw env reads, and timers inside `core/`/`lib/`.

## Safe Per-Project Learning
- Read `.agents/project-learnings.md` if present before code edits (skip for pure Q&A).
- Log repo-specific quirks or promoted guardrails there via surgical appends only; keep it ≤ 100 lines.
- **Never overwrite or delete** human-written rules in `AGENTS.md`, `CLAUDE.md`, or `.agents/project-learnings.md`.

## Done Gate & Token Discipline
- Run the repo's `verify` command (use quiet/summary flags first; inspect full logs only on failure) and confirm zero errors + runtime behavior.
- After non-trivial code changes, auto-update `.agents/status.md` (Last Recap + Verify + Plan) if present.
- Report commands run + observed results. Do not re-run passing checks without new edits.
- Load `.agents/skills/bastion/SKILL.md` **only** for `/bastion <init|harden|fix|guard|learn|audit|discover|recap|status>` commands or non-trivial multi-step changes.
