---
description: Run CodeGuard engineering workflows (init, harden, fix, guard, learn, audit, discover, recap, status)
argument-hint: <init|harden|fix|guard|learn|audit|discover|recap|status> [details]
---

Load `.agents/skills/codeguard/SKILL.md` (or `.claude/skills/codeguard/SKILL.md` / `~/.claude/skills/codeguard/SKILL.md`) and execute the subcommand requested in `$ARGUMENTS`:

- `init` -> Mode A (Bootstrap new project)
- `harden` -> Mode B (Harden existing project incrementally)
- `fix [bug]` -> Mode C (Reproduce-first bug fix & verify loop)
- `guard [mistake]` -> Mode D (Promote mistake into permanent lint/type/boundary/test check)
- `learn [note]` -> Mode E (Auto-discover profile or safely record learning)
- `audit` -> Mode F (Non-destructive skill + instruction audit & Skill Map overseer)
- `discover [goal]` -> Mode F (Search & vet reputable external skills/repos for this project's goals)
- `recap` -> Update `.agents/status.md` (using `references/status-template.md` if missing) with State, Last Recap, Current Plan, and Blockers from recent git history & verify state
- `status` -> Summarize `.agents/status.md` & `.agents/project-learnings.md` without editing files
- _(empty)_ -> Show this command list and ask which one to run
