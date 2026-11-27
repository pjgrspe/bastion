param(
    [ValidateSet("Project", "Global")]
    [string]$Scope = "Project",

    [string]$TargetDir = (Get-Location).Path,

    [switch]$Force
)

$ErrorActionPreference = "Stop"

$RepoRawBase = "https://raw.githubusercontent.com/pjgrspe/anti-slop-kit/main"
$SkillName = "anti-slop-engineering"
$SkillFiles = @(
    "SKILL.md",
    "references/stack-guardrails.md"
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

Write-Host "Installing Anti-Slop Kit (Scope: $Scope)..." -ForegroundColor Cyan

if ($Scope -eq "Project") {
    $resolvedTarget = (Resolve-Path $TargetDir).Path

    Install-KitFile -RepoRelativePath "AGENTS.md" -DestinationPath (Join-Path $resolvedTarget "AGENTS.md") -AllowOverwrite $Force.IsPresent
    Install-KitFile -RepoRelativePath "CLAUDE.md" -DestinationPath (Join-Path $resolvedTarget "CLAUDE.md") -AllowOverwrite $Force.IsPresent

    Install-SkillToDir -SkillRootDir (Join-Path $resolvedTarget ".agents\skills\$SkillName")
    Install-SkillToDir -SkillRootDir (Join-Path $resolvedTarget ".claude\skills\$SkillName")

    Write-Host ""
    Write-Host "Done! Installed into $resolvedTarget" -ForegroundColor Cyan
    Write-Host "Next: Ask your agent to use the 'anti-slop-engineering' skill to audit/harden or bootstrap this repo."
} else {
    $agySkillDir = Join-Path $HOME ".gemini\config\skills\$SkillName"
    $claudeSkillDir = Join-Path $HOME ".claude\skills\$SkillName"

    Install-SkillToDir -SkillRootDir $agySkillDir
    Install-SkillToDir -SkillRootDir $claudeSkillDir

    Write-Host ""
    Write-Host "Done! Installed globally for Antigravity and Claude Code." -ForegroundColor Cyan
    Write-Host "  Antigravity: $agySkillDir"
    Write-Host "  Claude Code: $claudeSkillDir"
}
