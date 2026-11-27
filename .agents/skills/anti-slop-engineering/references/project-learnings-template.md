# Project Learnings & Guardrail Profile

> **Managed safely by coding agents (Antigravity, Claude Code, Cursor, Codex).**
> **Rules for editing this file:**
> - **Never overwrite or delete** human-written notes or unrelated sections.
> - **Append or refine** specific entries only.
> - **Promote to code first:** If a learning can be enforced by a type, lint rule, boundary check, or test, add the mechanical check and log it under *Promoted Guardrails* instead of piling up prose.
> - **Keep it compact:** Deduplicate overlapping lessons; remove prose reminders once a deterministic check enforces them.

---

## 1. Project Profile (Auto-Discovered)

- **Stack / Languages:** _(fill on first audit, e.g., TypeScript / React / Python)_
- **Package Manager / Runtime:** _(e.g., pnpm, uv, dotnet)_
- **Single `verify` Command:** _(exact command to run typecheck + lint + test + build)_
- **Architecture Layers:** _(e.g., `src/core/` -> `src/domain/` -> `src/features/` -> `src/ui/`)_
- **Legacy / Exception Paths:** _(folders with temporary lint/type baselines that must not leak into new code)_

---

## 2. Project-Specific Invariants & Quirks

_(Facts unique to THIS repository that cannot be guessed from generic defaults — e.g., custom env bootstrap, DB migration workflow, flaky test workarounds, deployment constraints.)_

- _(none recorded yet)_

---

## 3. Promoted Guardrails (Mistake -> Permanent Constraint Log)

| Date | Failure / Mistake Observed | Permanent Mechanical Check Added | Location |
| :--- | :--- | :--- | :--- |
| _YYYY-MM-DD_ | _Example: Agent used raw `process.env` in UI_ | _Banned `process.env` outside `src/core/env.ts` via lint rule_ | _`eslint.config.js`_ |

---

## 4. Open Learning Candidates (Pending Promotion)

_(Patterns noticed once or twice that are not yet encoded as a lint/type/test check. Review periodically and either promote to Section 3 or prune.)_

- _(none recorded yet)_
