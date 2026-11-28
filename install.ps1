param(
    [ValidateSet("Project", "Global")]
    [string]$Scope = "Project",

    [string]$TargetDir = (Get-Location).Path,

    [switch]$Force
)

$ErrorActionPreference = "Stop"

$RepoRawBase = "https://raw.githubusercontent.com/pjgrspe/bastion/main"
$SkillName = "bastion"
$SkillFiles = @(
    "SKILL.md",
    "references/stack-guardrails.md",
    "references/project-learnings-template.md",
    "references/skill-audit.md",
    "references/claude-harness.md",
    "references/status-template.md"
)

$LocalRoot = if ($PSScriptRoot -and (Test-Path (Join-Path $PSScriptRoot "AGENTS.md"))) {
    $PSScriptRoot
} else {
    $null
}

function Install-KitFile {
    param(
        [string]$RepoRelativePath,
        [string]$DestinationPath,
        [bool]$AllowOverwrite = $true
    )

    if ((Test-Path $DestinationPath) -and -not $AllowOverwrite) {
        Write-Host "  [skip] $DestinationPath already exists (pass -Force to overwrite)" -ForegroundColor Yellow
        return
    }

    $parent = Split-Path -Parent $DestinationPath
    if ($parent -and -not (Test-Path $parent)) {
        New-Item -ItemType Directory -Force -Path $parent | Out-Null
    }

    if ($LocalRoot) {
        $src = Join-Path $LocalRoot ($RepoRelativePath -replace "/", "\")
        Copy-Item -Force -Path $src -Destination $DestinationPath
    } else {
        $url = "$RepoRawBase/$RepoRelativePath"
        Invoke-WebRequest -Uri $url -OutFile $DestinationPath -UseBasicParsing
    }

    Write-Host "  [ok]   $DestinationPath" -ForegroundColor Green
}

function Install-SkillToDir {
    param([string]$SkillRootDir)

    foreach ($rel in $SkillFiles) {
        $repoPath = ".agents/skills/$SkillName/$rel"
        $destPath = Join-Path $SkillRootDir ($rel -replace "/", "\")
        Install-KitFile -RepoRelativePath $repoPath -DestinationPath $destPath -AllowOverwrite $true
    }
}

Write-Host "Installing Bastion (Scope: $Scope)..." -ForegroundColor Cyan

if ($Scope -eq "Project") {
    $resolvedTarget = (Resolve-Path $TargetDir).Path

    Install-KitFile -RepoRelativePath "AGENTS.md" -DestinationPath (Join-Path $resolvedTarget "AGENTS.md") -AllowOverwrite $Force.IsPresent
    Install-KitFile -RepoRelativePath "CLAUDE.md" -DestinationPath (Join-Path $resolvedTarget "CLAUDE.md") -AllowOverwrite $Force.IsPresent

    Install-SkillToDir -SkillRootDir (Join-Path $resolvedTarget ".agents\skills\$SkillName")
    Install-SkillToDir -SkillRootDir (Join-Path $resolvedTarget ".claude\skills\$SkillName")
    Install-KitFile -RepoRelativePath ".claude/commands/bastion.md" -DestinationPath (Join-Path $resolvedTarget ".claude\commands\bastion.md") -AllowOverwrite $true

    # Never overwrite project-specific learnings, even with -Force
    $learningsPath = Join-Path $resolvedTarget ".agents\project-learnings.md"
    Install-KitFile -RepoRelativePath ".agents/skills/$SkillName/references/project-learnings-template.md" -DestinationPath $learningsPath -AllowOverwrite $false

    Write-Host ""
    Write-Host "Done! Installed Bastion into $resolvedTarget" -ForegroundColor Cyan
    Write-Host "Safe mode: existing AGENTS.md, CLAUDE.md, .agents\project-learnings.md, and any existing .agents\status.md are preserved."
    Write-Host "Optional: run /bastion recap only if you want a manual .agents\status.md override (Meridian works passively without it)."
    Write-Host "Commands ready: /bastion init | harden | fix | guard | learn | audit | discover | recap | status"
} else {
    $agySkillDir = Join-Path $HOME ".gemini\config\skills\$SkillName"
    $claudeSkillDir = Join-Path $HOME ".claude\skills\$SkillName"
    $claudeCmdPath = Join-Path $HOME ".claude\commands\bastion.md"

    Install-SkillToDir -SkillRootDir $agySkillDir
    Install-SkillToDir -SkillRootDir $claudeSkillDir
    Install-KitFile -RepoRelativePath ".claude/commands/bastion.md" -DestinationPath $claudeCmdPath -AllowOverwrite $true

    Write-Host ""
    Write-Host "Done! Installed Bastion globally for Antigravity and Claude Code." -ForegroundColor Cyan
    Write-Host "  Antigravity: $agySkillDir"
    Write-Host "  Claude Code: $claudeSkillDir"
    Write-Host "  Slash cmd:   $claudeCmdPath (/bastion <cmd>)"
}
