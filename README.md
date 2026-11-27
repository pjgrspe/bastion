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

## Usage Prompts

Once installed in a repo (or globally), tell **any** coding agent:

- **Existing project:** *"Use the `anti-slop-engineering` skill to audit and harden this repo."*
- **New project:** *"Use the `anti-slop-engineering` skill to bootstrap guardrails for this project."*
- **After a bug / agent mistake:** *"Use Mode D of `anti-slop-engineering` to turn this mistake into a permanent lint/type/boundary constraint."*

---

## What's Inside

| File | Purpose | Used By |
| :--- | :--- | :--- |
| `AGENTS.md` | Lean, always-on operating rules (Trust Pyramid, Prove It Works, Mistake → Constraint, Done Gate) | Antigravity, Cursor, Codex, OpenCode |
| `CLAUDE.md` | Thin `@AGENTS.md` pointer so Claude Code reads the exact same source of truth | Claude Code |
| `.agents/skills/anti-slop-engineering/SKILL.md` | 4-mode playbook (Bootstrap, Harden Existing, Daily Verify Loop, Mistake → Constraint) | Antigravity, Claude Code, Cursor, Codex |
| `.agents/skills/anti-slop-engineering/references/stack-guardrails.md` | Copy-pasteable TypeScript/React, Python, and high-criticality guardrail checklists | Loaded on demand by `SKILL.md` |
| `install.ps1` / `install.sh` | One-command project or global installers | Windows / macOS / Linux |
