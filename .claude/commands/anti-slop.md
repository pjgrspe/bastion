---
description: Run Anti-Slop Engineering workflows (init, harden, fix, guard, learn, audit, discover, status)
argument-hint: <init|harden|fix|guard|learn|audit|discover|status> [details]
---

Load `.agents/skills/anti-slop-engineering/SKILL.md` (or `.claude/skills/anti-slop-engineering/SKILL.md` / `~/.claude/skills/anti-slop-engineering/SKILL.md`) and execute the subcommand requested in `$ARGUMENTS`:

- `init` -> Mode A (Bootstrap new project)
- `harden` -> Mode B (Harden existing project incrementally)
- `fix [bug]` -> Mode C (Reproduce-first bug fix & verify loop)
- `guard [mistake]` -> Mode D (Promote mistake into permanent lint/type/boundary/test check)
- `learn [note]` -> Mode E (Auto-discover profile or safely record learning)
- `audit` -> Mode F (Non-destructive skill + instruction audit & Skill Map overseer)
- `discover [goal]` -> Mode F (Search & vet reputable external skills/repos for this project's goals)
- `status` -> Summarize `.agents/project-learnings.md` (profile, verify cmd, guardrails, skill map) without editing files
- _(empty)_ -> Show this command list and ask which one to run
