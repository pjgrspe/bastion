# Engineering Operating Rules (Anti-Slop Standard)

These rules apply to all coding agents working in this repository (Antigravity, Claude Code, Cursor, Codex, etc.).

## 1. The Trust Pyramid (Deterministic First, Prose Last)

Prefer mechanical enforcement over verbal reminders, in this exact order:

1. **Types & Schemas** — Make invalid states unrepresentable.
2. **Linters & Architectural Boundaries** — Ban footgun APIs and illegal cross-layer imports automatically.
3. **Automated & Runtime Verification** — Prove behavior via tests and real execution.
4. **Prose Rules (`AGENTS.md` / prompts)** — Last resort, only for judgment calls that cannot be checked mechanically.

## 2. Non-Negotiable Engineering Principles

- **Prove It Works:** Never declare a task done without empirical evidence from running the real code, tests, CLI, API, or UI. "Looks right" or "should work" is not verification.
- **Reproduce Before Fixing:** For every bug, first write a failing test or minimal reproduction command that demonstrates the bug, then fix it and verify the reproduction passes.
- **Fix Root Causes:** Do not paper over symptoms with defensive hacks, silent `catch` blocks, retries, or `any`/type casts.
- **Mistake → Permanent Constraint:** When you (or a previous change) make a repeatable mistake, do not just patch the diff. Add a lint rule, type guard, import boundary, or regression test so that class of mistake cannot recur.
- **Sequence Work:** Break multi-part changes into small, independently verifiable slices. Run verification after each slice.
- **Test Behavior, Not Implementation:** Assert observable inputs/outputs and invariants rather than internal private state or brittle mocks.
- **Avoid Nuance-Heavy APIs in Feature Code:** Keep tricky primitives (e.g., raw `useEffect`, raw SQL strings, unvalidated `fetch`, direct `process.env` access, manual timers) isolated inside a vetted `core/` or `lib/` layer rather than scattered through feature code.

## 3. Mandatory Done Gate

Before finishing any code change, you MUST:

1. Run the project's verification command(s) (typecheck, lint, test, build) and confirm zero errors.
2. Verify the actual changed behavior at runtime (test output, CLI/HTTP probe, or UI check).
3. Report **verification artifacts** (commands run + observed results) in your final response, not just a summary of files edited.

## 4. When to Load the `anti-slop-engineering` Skill

Load `.agents/skills/anti-slop-engineering/SKILL.md` whenever you are:

- Bootstrapping guardrails in a **new** project.
- Auditing or hardening an **existing** codebase against AI slop.
- Converting a bug or agent mistake into a **permanent deterministic constraint** (lint rule, boundary check, or test).
- Running a multi-step bug fix or refactor that needs a strict verification loop.
