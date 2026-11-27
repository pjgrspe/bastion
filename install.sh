#!/usr/bin/env bash
set -euo pipefail

REPO_RAW_BASE="https://raw.githubusercontent.com/pjgrspe/anti-slop-kit/main"
SKILL_NAME="anti-slop-engineering"
SCOPE="project"
TARGET_DIR="$(pwd)"
FORCE="false"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --global) SCOPE="global"; shift ;;
    --project) SCOPE="project"; shift ;;
    --target) TARGET_DIR="$2"; shift 2 ;;
    --force) FORCE="true"; shift ;;
    -h|--help)
      echo "Usage: install.sh [--project|--global] [--target DIR] [--force]"
      exit 0
      ;;
    *) echo "Unknown option: $1" >&2; exit 1 ;;
  esac
done

SCRIPT_DIR=""
if [[ -n "${BASH_SOURCE[0]:-}" && -f "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/AGENTS.md" ]]; then
  SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fi

install_file() {
  local repo_rel="$1"
  local dest="$2"
  local allow_overwrite="$3"

  if [[ -f "$dest" && "$allow_overwrite" != "true" ]]; then
    echo "  [skip] $dest already exists (pass --force to overwrite)"
    return
  fi

  mkdir -p "$(dirname "$dest")"
  if [[ -n "$SCRIPT_DIR" ]]; then
    cp "$SCRIPT_DIR/$repo_rel" "$dest"
  else
    curl -fsSL "$REPO_RAW_BASE/$repo_rel" -o "$dest"
  fi
  echo "  [ok]   $dest"
}

install_skill_to_dir() {
  local skill_dir="$1"
  install_file ".agents/skills/$SKILL_NAME/SKILL.md" "$skill_dir/SKILL.md" "true"
  install_file ".agents/skills/$SKILL_NAME/references/stack-guardrails.md" "$skill_dir/references/stack-guardrails.md" "true"
  install_file ".agents/skills/$SKILL_NAME/references/project-learnings-template.md" "$skill_dir/references/project-learnings-template.md" "true"
  install_file ".agents/skills/$SKILL_NAME/references/skill-audit.md" "$skill_dir/references/skill-audit.md" "true"
  install_file ".agents/skills/$SKILL_NAME/references/claude-harness.md" "$skill_dir/references/claude-harness.md" "true"
}

echo "Installing Anti-Slop Kit (scope: $SCOPE)..."

if [[ "$SCOPE" == "project" ]]; then
  install_file "AGENTS.md" "$TARGET_DIR/AGENTS.md" "$FORCE"
  install_file "CLAUDE.md" "$TARGET_DIR/CLAUDE.md" "$FORCE"
  install_skill_to_dir "$TARGET_DIR/.agents/skills/$SKILL_NAME"
  install_skill_to_dir "$TARGET_DIR/.claude/skills/$SKILL_NAME"
  install_file ".claude/commands/anti-slop.md" "$TARGET_DIR/.claude/commands/anti-slop.md" "true"
  # Never overwrite project-specific learnings, even with --force
  install_file ".agents/skills/$SKILL_NAME/references/project-learnings-template.md" "$TARGET_DIR/.agents/project-learnings.md" "false"
  echo ""
  echo "Done! Installed into $TARGET_DIR"
  echo "Safe mode: existing AGENTS.md, CLAUDE.md, and .agents/project-learnings.md are preserved."
  echo "Commands ready: /anti-slop init | harden | fix | guard | learn | audit | status"
else
  install_skill_to_dir "$HOME/.gemini/config/skills/$SKILL_NAME"
  install_skill_to_dir "$HOME/.claude/skills/$SKILL_NAME"
  install_file ".claude/commands/anti-slop.md" "$HOME/.claude/commands/anti-slop.md" "true"
  echo ""
  echo "Done! Installed globally for Antigravity and Claude Code (/anti-slop <cmd>)."
fi
