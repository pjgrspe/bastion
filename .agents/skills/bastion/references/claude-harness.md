# Claude Code Harness Reference (Load Only in Mode A/B for Claude Code)

Enforce prohibitions and verification in the harness rather than prose.

## 1. Hard `permissions.deny` Rules (`.claude/settings.json`)
Merge these non-destructively into `.claude/settings.json` (checked before Auto Mode):
```json
{
  "permissions": {
    "deny": [
      "Read(./.env)",
      "Read(./.env.*)",
      "Read(./secrets/**)",
      "Bash(rm -rf *)",
      "Bash(git push --force*)",
      "Bash(git reset --hard*)"
    ]
  }
}
```
Also enable OS sandboxing (`/sandbox`) and block sensitive host paths like `~/.ssh` in `filesystem.denyRead`.

## 2. Blocking Verification Hook (`exit code 2`)
Standard test runners exit `1` (non-blocking in Claude Code hooks). Wrap your repo's `verify` command so failures exit `2`, forcing Claude Code to stay in the loop and fix failures before stopping.

**`.claude/hooks/verify-gate.sh` (macOS / Linux):**
```bash
#!/usr/bin/env bash
set -uo pipefail
# Replace with your repo's quiet verify command:
if ! npm run verify --silent; then
  echo "Verification failed. Fix errors and re-run." >&2
  exit 2
fi
```

**`.claude/hooks/verify-gate.ps1` (Windows):**
```powershell
# Replace with your repo's quiet verify command:
npm run verify --silent
if ($LASTEXITCODE -ne 0) {
  [Console]::Error.WriteLine("Verification failed. Fix errors and re-run.")
  exit 2
}
```

Wire into `.claude/settings.json` under `hooks.Stop` or `hooks.TaskCompleted` (only after confirming the repo has a fast, deterministic `verify` command so it does not create infinite loops).
