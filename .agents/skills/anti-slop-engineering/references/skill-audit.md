# Skill Audit & Orchestration Reference (Load Only in Mode F)

## 1. Non-Destructive Skill Audit Procedure
Scan `.agents/skills/*/SKILL.md` and `.claude/skills/*/SKILL.md` (read YAML frontmatter first to save tokens; open full body only when checking a flagged skill).

Check each skill against the live repo (`package.json`, `pyproject.toml`, paths, scripts):
1. **Stale:** References missing files, dead scripts, removed libraries, or outdated commands.
2. **Conflicting / Overlapping:** Two skills cover the same trigger or contradict each other.
3. **Mirror Drift:** Same skill in `.agents/skills/` and `.claude/skills/` has diverged.
4. **Trust-Pyramid Leak:** Skill enforces style/imports in prose that a linter/typecheck should enforce.
5. **Token Bloat:** Frontmatter description > 50 words, or always-loaded body > 1,500 tokens without `references/`.

### Output Format (Report First — Never Auto-Delete)
Present a concise table before touching any existing skill:
| Skill | Status (`OK` / `Stale` / `Overlap` / `Drift` / `Bloat`) | Evidence | Recommended Action (`Keep` / `Trim` / `Merge` / `Sync` / `Archive`) |
| :--- | :--- | :--- | :--- |

Wait for user approval before archiving, merging, or editing any third-party/existing skill.

## 2. Skill Overseer & Composition Architecture
Use `.agents/project-learnings.md` (Section 5: *Active Skill Map & Combos*) as the lightweight **overseer index** (~10 rows max) so every agent knows which skills exist and how to combine them without loading everything.

### Composition Rules
- **Cap active skills at 2–3 per task:** 1 primary **Domain Skill** (owns *how to build X*) + `anti-slop-engineering` as the **Verification Wrapper** (owns *reproduce -> verify -> Mistake -> Constraint*).
- **Phase-gate sequentially:** Load a skill only when entering its phase (e.g., `schema-skill` for migration -> `ui-skill` for component -> `verify` gate).
- **Precedence on conflict:**
  1. Deterministic repo checks (types, linters, tests)
  2. Repo-specific domain skills & `.agents/project-learnings.md`
  3. Generic/global skills (`anti-slop-engineering` defaults)
- **Single source of truth:** Keep canonical skills in `.agents/skills/` and sync (or symlink) to `.claude/skills/` so Antigravity and Claude Code never drift.
