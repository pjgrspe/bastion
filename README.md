# Anti-Slop Kit (`pjgrspe/anti-slop-kit`)

A portable, cross-agent rules & skill kit inspired by Lauren Tan's (*"All Code Is Slop (Except Mine)"* / `pstack`) engineering principles. Works across **Antigravity**, **Claude Code**, **Cursor**, **Codex**, and **OpenCode** on **new or existing** projects.

---

## Quick Install

### 1. Install into the Current Project (New or Existing Repo)

Installs `AGENTS.md`, `CLAUDE.md`, `.agents/skills/anti-slop-engineering/`, and `.claude/skills/anti-slop-engineering/` (safely skips existing `AGENTS.md`/`CLAUDE.md` unless `-Force` / `--force` is passed).

**Windows (PowerShell):**
```powershell
irm https://raw.githubusercontent.com/pjgrspe/anti-slop-kit/main/install.ps1 | iex
```

**macOS / Linux:**
```bash
curl -fsSL https://raw.githubusercontent.com/pjgrspe/anti-slop-kit/main/install.sh | bash
```

### 2. Install Globally (Every Project on Your Machine)

Installs the `anti-slop-engineering` skill globally for both **Antigravity** (`~/.gemini/config/skills/`) and **Claude Code** (`~/.claude/skills/`).

**Windows (PowerShell):**
```powershell
& ([scriptblock]::Create((irm https://raw.githubusercontent.com/pjgrspe/anti-slop-kit/main/install.ps1))) -Scope Global
```

**macOS / Linux:**
```bash
curl -fsSL https://raw.githubusercontent.com/pjgrspe/anti-slop-kit/main/install.sh | bash -s -- --global
```

### 3. Via Agent Skills CLI (`skills.sh`)
```bash
npx skills add pjgrspe/anti-slop-kit
```

---

## Commands

Works as a native slash command in **Claude Code** (`.claude/commands/anti-slop.md`) and as a direct command trigger in **Antigravity, Cursor, and Codex**:

| Command | What It Does |
| :--- | :--- |
| `/anti-slop init` | Bootstrap strict types, linting, boundaries, and a `verify` gate in a **new** project |
| `/anti-slop harden` | Incrementally harden an **existing** repo without breaking legacy code |
| `/anti-slop fix <bug>` | Reproduce-first bug fix + empirical runtime verification loop |
| `/anti-slop guard <mistake>` | Convert a bug or agent mistake into a permanent lint/type/boundary/test rule |
| `/anti-slop learn [note]` | Auto-discover repo profile or safely append a learning to `.agents/project-learnings.md` |
| `/anti-slop audit` | Non-destructive audit of installed skills (stale/overlap/bloat) + build the Skill Map |
| `/anti-slop discover [goal]` | Search & vet reputable skill repos/registries for this project's stack & goals (approval-gated) |
| `/anti-slop recap` | Update `.agents/status.md` (State, Last Recap, Current Plan, Blockers) for Manager overview |
| `/anti-slop status` | Read-only summary of your repo's `.agents/status.md` and `.agents/project-learnings.md` |

---

## How Safe Self-Learning Works

Projects vary wildly in stack, legacy code, and conventions. To keep learning **project-specific and non-destructive**:

- **Separated memory:** Project learnings live in `.agents/project-learnings.md` (created once from template), completely separate from the core `anti-slop-engineering` skill files.
- **Upgrade-safe:** Re-running `install.ps1` / `install.sh` updates the core skill while **never overwriting** `.agents/project-learnings.md` (even with `-Force` / `--force`) and **never overwriting** existing `AGENTS.md` / `CLAUDE.md` unless you explicitly pass `-Force` / `--force`.
- **Append-only & Trust-Pyramid-first:** Agents auto-discover your stack/`verify` command on first run, log project quirks safely, and promote repeatable mistakes into deterministic lint/type/test checks rather than bloating prose.
- **Token-optimized:** Ultra-compact `AGENTS.md` (~380 tokens), lazy-loaded skill references, quiet verification output by default, and a hard ≤ 100-line cap on `.agents/project-learnings.md`.

---

## What's Inside

| File | Purpose | Used By |
| :--- | :--- | :--- |
| `AGENTS.md` | Lean, always-on operating rules (Trust Pyramid, Prove It Works, Mistake → Constraint, Safe Self-Learning, Done Gate) | Antigravity, Cursor, Codex, OpenCode |
| `CLAUDE.md` | Thin `@AGENTS.md` pointer so Claude Code reads the exact same source of truth | Claude Code |
| `.agents/skills/anti-slop-engineering/SKILL.md` | 6-mode playbook (Bootstrap, Harden, Daily Verify, Mistake → Constraint, Safe Self-Learn, Skill Audit & Orchestration) | Antigravity, Claude Code, Cursor, Codex |
| `.agents/skills/anti-slop-engineering/references/stack-guardrails.md` | Copy-pasteable TypeScript/React, Python, and high-criticality guardrail checklists | Loaded on demand by `SKILL.md` |
| `.agents/skills/anti-slop-engineering/references/project-learnings-template.md` | Template used to initialize `.agents/project-learnings.md` once per repo | Installer & `SKILL.md` Mode E |
| `.agents/skills/anti-slop-engineering/references/skill-audit.md` | Non-destructive skill + instruction audit (`AGENTS.md`/`CLAUDE.md`) & multi-skill composition rules | Loaded on demand by `SKILL.md` Mode F |
| `.agents/skills/anti-slop-engineering/references/claude-harness.md` | Claude Code `permissions.deny` rules & blocking `exit code 2` verification hook templates | Loaded on demand by `SKILL.md` Mode A/B |
| `install.ps1` / `install.sh` | Safe, non-destructive project or global installers | Windows / macOS / Linux |
