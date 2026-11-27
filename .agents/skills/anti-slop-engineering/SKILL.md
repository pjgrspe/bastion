---
name: anti-slop-engineering
description: >-
  Deterministic guardrails, verification loops, and safe per-project self-learning.
  Use ONLY when bootstrapping a new repo, hardening an existing repo, promoting a
  mistake to a lint/type/boundary rule, or running a non-trivial multi-step code change.
---

# Anti-Slop Engineering Playbook

## Commands (`/anti-slop <cmd>`)
Route user commands directly to one mode without asking:
- `/anti-slop init` → **Mode A** (Bootstrap new repo)
- `/anti-slop harden` → **Mode B** (Harden existing repo incrementally)
- `/anti-slop fix [bug]` → **Mode C** (Reproduce-first bug fix & verify loop)
- `/anti-slop guard [mistake]` → **Mode D** (Promote mistake to permanent check)
- `/anti-slop learn [note]` → **Mode E** (Discover profile or safely log learning)
- `/anti-slop audit` → **Mode F** (Audit installed skills & build Skill Map)
- `/anti-slop status` → Read-only summary of `.agents/project-learnings.md`

## Token & Context Rules (Read First)
- **Skip this skill** for simple Q&A or trivial 1-file edits covered by `AGENTS.md`.
- **Lazy-load references:** Open [stack-guardrails.md](./references/stack-guardrails.md) only in Mode A/B/D, [project-learnings-template.md](./references/project-learnings-template.md) only when creating `.agents/project-learnings.md`, and [skill-audit.md](./references/skill-audit.md) only in Mode F.
- **Read `.agents/project-learnings.md` once** (if present) before editing.
- **Quiet verification:** Run tests/linters with concise output (`-q`, `--silent`, `--reporter=dot`) first; inspect verbose logs only on failure. Never re-run passing checks without new edits.

## Select One Mode

### Mode A — Bootstrap New Project
1. Add one `verify` command (typecheck + lint + test + build).
2. Enable strict static typing (no implicit `any`, unchecked nulls, or silent escapes).
3. Separate `core/` (primitives), `domain/` (logic), `ui/`/`api/` (entry points) and enforce import boundaries via linter.
4. Wrap footgun APIs (`useEffect`, raw SQL, raw `fetch`, env vars) in `core/` and lint-ban direct use elsewhere.
5. Prove the gate catches an intentional violation, revert it, and confirm `verify` passes.

### Mode B — Harden Existing Project (Incremental Ratchet)
1. Inspect existing scripts, linters, tests, and recent bug/revert commits.
2. Wire existing checks into a single `verify` command.
3. Target top 3–5 recurring failure modes with lint/type/boundary rules.
4. Apply strictness to **new/touched files** using scoped baselines/overrides for legacy paths—never disable rules globally.
5. Run `verify` and confirm green.

### Mode C — Daily Task & Bug-Fix Loop
1. Read relevant files and conventions first.
2. **Bugs:** Write a minimal failing test/repro and observe it fail before editing code.
3. Sequence multi-file work into small green slices; fix root causes only.
4. Run `verify` + exercise the real changed behavior (CLI, API, or UI).
5. Report exact commands and observed results.

### Mode D — Mistake → Permanent Constraint
Climb down the Trust Pyramid to the strongest mechanical check:
- Bad shape / null bug → strict type or schema (Zod/Pydantic)
- Footgun API usage → lint rule (`no-restricted-imports` / `no-restricted-syntax` / Ruff `TID`)
- Cross-layer import → boundary rule (`dependency-cruiser` / `import-linter`)
- State/concurrency bug → property-based test (`fast-check` / `hypothesis`) or formal spec (TLA+/Lean)
- Pure judgment only → 1-line note in `.agents/project-learnings.md`

Verify the new check fails on the bad pattern and passes on the fix, then log it via Mode E.

### Mode E — Safe Per-Project Self-Learning
Store repo-specific memory in `.agents/project-learnings.md`—never mutate `SKILL.md` or clobber existing `AGENTS.md` / `CLAUDE.md`.
1. **Non-destructive:** Append or make surgical edits only; never delete human-written instructions.
2. **Lazy init:** If `.agents/project-learnings.md` is missing, create it from `project-learnings-template.md` and fill Section 1 from real repo inspection.
3. **Promote first:** Prefer adding a mechanical check (Mode D) + a 1-row log in Section 3 over prose.
4. **Hard size cap (≤ 100 lines):** 1-line bullets only; deduplicate before adding; delete prose reminders once enforced by a linter/type/test.
5. **Safe config changes:** Updating `.agents/project-learnings.md` with verified facts is safe automatically; broader legacy linter/compiler changes must use Mode B scoped overrides and pass `verify`.

### Mode F — Skill Audit & Orchestration (Overseer)
Load [skill-audit.md](./references/skill-audit.md) when auditing installed skills or designing multi-skill combos:
1. **Audit (read-only first):** Scan `.agents/skills/` and `.claude/skills/` frontmatter against live repo files/scripts to flag stale, overlapping, drifted, or bloated skills. Never delete or edit existing skills without user approval.
2. **Overseer Map:** Maintain a compact *Active Skill Map & Combos* table in `.agents/project-learnings.md` (Section 5) listing each active skill's role, trigger, and proven combos.
3. **Combine cleanly:** Cap at 2–3 skills per task (Domain Skill builds, `anti-slop-engineering` verifies); load sequentially by phase; repo-specific skills override generic defaults on conflict.
