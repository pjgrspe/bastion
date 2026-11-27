# Bastion (`pjgrspe/bastion`)

A portable, token-optimized cross-agent engineering guardrail & skill kit. Works across **Antigravity**, **Claude Code**, **Cursor**, **Codex**, and **OpenCode** on **new or existing** projects.

---

## Quick Install

### Recommended (Corporate / IT-Safe — Clone & Inspect Locally)

Clone once, then run the local installer against any project (avoids piping remote URLs into `iex`/`bash`, which corporate EDR tools often flag):

```powershell
git clone https://github.com/pjgrspe/bastion.git
.\bastion\install.ps1 -Scope Project -TargetDir "C:\path\to\your-repo"
```

Or install globally for Antigravity + Claude Code:
```powershell
.\bastion\install.ps1 -Scope Global
```

### Quick Remote One-Liners (Personal Machines Only)

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
| `/bastion recap` | Update `.agents/status.md` (State, Last Recap, Current Plan, Blockers) for Agent Manager |
| `/bastion status` | Read-only summary of your repo's `.agents/status.md` and `.agents/project-learnings.md` |

---

## How Safe Self-Learning Works

- **Separated memory:** Project learnings live in `.agents/project-learnings.md` and status in `.agents/status.md` (created once from templates), separate from the core `bastion` skill files.
- **Upgrade-safe:** Re-running `install.ps1` / `install.sh` updates the core skill while **never overwriting** `.agents/project-learnings.md` or `.agents/status.md` (even with `-Force` / `--force`) and **never overwriting** existing `AGENTS.md` / `CLAUDE.md` unless `-Force` / `--force` is passed.
- **Token-optimized:** Lean `AGENTS.md` (~470 tokens), lazy-loaded `references/`, quiet verification output, and a hard ≤ 100-line cap on `.agents/project-learnings.md`.

---

## Companion Dashboard

Pair with **[Agent Manager](https://github.com/pjgrspe/agent-manager)** for a multi-project command center that reads `.agents/status.md` and auto-syncs Git recaps across all your repos.
