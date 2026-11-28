# Bastion (`pjgrspe/bastion`)

A portable, token-optimized cross-agent engineering guardrail & skill kit. Works across **Antigravity**, **Claude Code**, **Cursor**, **Codex**, and **OpenCode** on **new or existing** projects.

---

## Quick Install

### Recommended (Clone & Run Locally)

Clone once, then run the local installer against any project:

```powershell
git clone https://github.com/pjgrspe/bastion.git
.\bastion\install.ps1 -Scope Project -TargetDir "C:\path\to\your-repo"
```

Or install globally for Antigravity + Claude Code:
```powershell
.\bastion\install.ps1 -Scope Global
```

### Quick Remote One-Liners

**Windows (PowerShell):**
```powershell
irm https://raw.githubusercontent.com/pjgrspe/bastion/main/install.ps1 | iex
```

**macOS / Linux:**
```bash
curl -fsSL https://raw.githubusercontent.com/pjgrspe/bastion/main/install.sh | bash
```

### Via Agent Skills CLI (`skills.sh`)
```bash
npx skills add pjgrspe/bastion
```

---

## Commands

Works as a native slash command in **Claude Code** (`.claude/commands/bastion.md`) and as a direct command trigger in **Antigravity, Cursor, and Codex**:

| Command | What It Does |
| :--- | :--- |
| `/bastion init` | Bootstrap strict types, linting, boundaries, and a `verify` gate in a **new** project |
| `/bastion harden` | Incrementally harden an **existing** repo without breaking legacy code |
| `/bastion fix <bug>` | Reproduce-first bug fix + empirical runtime verification loop |
| `/bastion guard <mistake>` | Convert a bug or agent mistake into a permanent lint/type/boundary/test rule |
| `/bastion learn [note]` | Auto-discover repo profile or safely append a learning to `.agents/project-learnings.md` |
| `/bastion audit` | Non-destructive audit of installed skills + `AGENTS.md`/`CLAUDE.md` + build the Skill Map |
| `/bastion discover [goal]` | Search & vet reputable skill repos/registries for this project's stack & goals (approval-gated) |
| `/bastion recap` | *(Optional)* Create or update `.agents/status.md` (manual State, Recap, Plan, or Blockers override) |
| `/bastion status` | Read-only summary of `.agents/project-learnings.md` (and optional `.agents/status.md`, if present) |

---

## How Safe Self-Learning Works

- **Separated memory:** Project learnings live in `.agents/project-learnings.md`, separate from the core `bastion` skill files. `.agents/status.md` is strictly **optional**—use it only if you want to pin manual blockers, mark `Waiting on Review` without an open PR, or maintain a custom recap/plan override.
- **Upgrade-safe:** Re-running `install.ps1` / `install.sh` updates the core skill while **never overwriting** `.agents/project-learnings.md` or `.agents/status.md` (even with `-Force` / `--force`) and **never overwriting** existing `AGENTS.md` / `CLAUDE.md` unless `-Force` / `--force` is passed.
- **Token-optimized:** Lean `AGENTS.md` (~470 tokens), lazy-loaded `references/`, quiet verification output, and a hard ≤ 100-line cap on `.agents/project-learnings.md`.

---

## Companion Dashboard

Pair with **[Citadel](https://github.com/pjgrspe/citadel)** for a multi-project dashboard that works passively out of the box on any Git repo or GitHub project—no `.agents/status.md` or Bastion install required. Citadel derives state, recaps, plans, and activity automatically from Git, GitHub (PRs, CI, issues, milestones), and passive agent sessions (Claude Code, Antigravity), and treats `.agents/status.md` strictly as an optional manual override.
