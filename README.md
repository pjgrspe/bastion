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
- **Audit & orchestrate existing skills:** *"Use Mode F of `anti-slop-engineering` to audit our installed skills for staleness/overlap and build our Skill Map."*

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
| `.agents/skills/anti-slop-engineering/references/skill-audit.md` | Non-destructive skill health audit & multi-skill composition rules | Loaded on demand by `SKILL.md` Mode F |
| `install.ps1` / `install.sh` | Safe, non-destructive project or global installers | Windows / macOS / Linux |
