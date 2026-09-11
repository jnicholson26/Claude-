<#
.SYNOPSIS
  Mirrors MBL Energy's Claude crew skills from the local skills cache into this
  repo, strips Giga's private Playbook, verifies nothing private leaked, and pushes.

.DESCRIPTION
  Run by the "Claude repo sync" scheduled task. Safe to run by hand.

  The guard is structural, not a guessed word list. See Test-Safety below:
    A. giga/SKILL.md must end with the exact approved Playbook placeholder.
    B. No repo file may contain any substantial line of the real Playbook body,
       read live from the cache. This updates itself as the Playbook changes.
    C. A small literal tripwire list (tools/forbidden-strings.txt) catches known
       private tokens even if they have since been edited out of the Playbook.

  Any failure aborts before `git add`. Nothing is deleted on failure.

.PARAMETER DryRun
  Do everything except commit and push.
#>
[CmdletBinding()]
param(
    [switch]$DryRun,
    [string]$RepoRoot = (Split-Path -Parent $PSScriptRoot)
)

$ErrorActionPreference = 'Stop'

$CrewSkills = @('giga','watt','frick','frack','bodie','prologis-commissioning','scoop-api-ops')

# The exact text that replaces the private Playbook in the published copy.
$PlaceholderLines = @(
    '## Playbook',
    '',
    "Giga's Playbook is Jason's private working memory and is deliberately NOT in this repository. It lives only in the live skill on Jason's Claude account."
)

$Utf8NoBom = New-Object System.Text.UTF8Encoding($false)

function Read-Text([string]$Path) {
    return [System.IO.File]::ReadAllText($Path, $Utf8NoBom)
}

function Write-Text([string]$Path, [string]$Text) {
    # UTF-8 without BOM, to match how the skill files are authored.
    [System.IO.File]::WriteAllText($Path, $Text, $Utf8NoBom)
}

function Fail([string]$Message) {
    throw "ABORT: $Message"
}

function Get-RepoTextFiles([string]$Root) {
    Get-ChildItem -LiteralPath $Root -Recurse -File |
        Where-Object { $_.FullName -notlike '*\.git\*' } |
        Where-Object { @('.md','.txt','.json','.yml','.yaml') -contains $_.Extension }
}

# --- 1. locate the skills cache -------------------------------------------

function Find-SkillsCache {
    $base = Join-Path $env:APPDATA 'Claude\local-agent-mode-sessions\skills-plugin'
    if (-not (Test-Path $base)) {
        Fail "skills cache base not found at '$base'. This is an app-internal path; a Claude update may have moved it. Nothing was changed."
    }
    $found = Get-ChildItem -Path $base -Directory -Recurse -Filter 'skills' -ErrorAction SilentlyContinue |
             Sort-Object LastWriteTime -Descending
    if (-not $found -or $found.Count -eq 0) {
        Fail "no 'skills' folder found under '$base'. The cache layout may have changed. Nothing was changed."
    }
    return $found[0].FullName
}

# --- 2. verify all seven crew skills are present ---------------------------

function Assert-CrewPresent([string]$Cache) {
    $missing = @()
    foreach ($s in $CrewSkills) {
        if (-not (Test-Path (Join-Path $Cache $s))) { $missing += $s }
    }
    if ($missing.Count -gt 0) {
        Fail ("only " + ($CrewSkills.Count - $missing.Count) + " of " + $CrewSkills.Count +
              " crew skills found in the cache. Missing: " + ($missing -join ', ') +
              ". Refusing to push a partial mirror.")
    }
}

# --- 3. mirror each skill folder ------------------------------------------

function Sync-SkillFolder([string]$Cache, [string]$Dest, [string]$Skill) {
    $src = Join-Path $Cache $Skill
    $dst = Join-Path $Dest $Skill
    if (-not (Test-Path $dst)) { New-Item -ItemType Directory -Path $dst -Force | Out-Null }

    $srcFiles = Get-ChildItem -LiteralPath $src -Recurse -File
    foreach ($f in $srcFiles) {
        $rel = $f.FullName.Substring($src.Length).TrimStart('\')
        $target = Join-Path $dst $rel
        $targetDir = Split-Path -Parent $target
        if (-not (Test-Path $targetDir)) { New-Item -ItemType Directory -Path $targetDir -Force | Out-Null }
        Copy-Item -LiteralPath $f.FullName -Destination $target -Force
    }

    # Remove files that no longer exist upstream, so the mirror is a true mirror.
    $srcRel = @($srcFiles | ForEach-Object { $_.FullName.Substring($src.Length).TrimStart('\') })
    foreach ($f in (Get-ChildItem -LiteralPath $dst -Recurse -File)) {
        $rel = $f.FullName.Substring($dst.Length).TrimStart('\')
        if ($srcRel -notcontains $rel) {
            Remove-Item -LiteralPath $f.FullName -Force
            Write-Verbose "removed stale $Skill/$rel"
        }
    }
}

# --- 4. strip the private Playbook out of giga/SKILL.md --------------------

function Remove-Playbook([string]$GigaSkillPath) {
    if (-not (Test-Path $GigaSkillPath)) { Fail "giga/SKILL.md not found at '$GigaSkillPath'." }

    $text = Read-Text $GigaSkillPath
    $nl   = if ($text -match "`r`n") { "`r`n" } else { "`n" }
    $lines = $text -split "`r?`n"

    $idx = -1
    for ($i = 0; $i -lt $lines.Count; $i++) {
        if ($lines[$i] -match '^##\s+Playbook') { $idx = $i; break }
    }

    if ($idx -lt 0) {
        Fail ("no '## Playbook' marker found in giga/SKILL.md. The skill's format changed, " +
              "so this file may now carry Jason's private memory with nothing to truncate at. " +
              "Nothing was committed.")
    }

    $kept = if ($idx -eq 0) { @() } else { $lines[0..($idx - 1)] }

    # Drop trailing blank lines from the kept part so spacing stays consistent.
    while ($kept.Count -gt 0 -and [string]::IsNullOrWhiteSpace($kept[-1])) {
        $kept = $kept[0..($kept.Count - 2)]
    }

    $out = (@($kept) + @('') + $PlaceholderLines) -join $nl
    Write-Text $GigaSkillPath ($out + $nl)

    return ($lines.Count - $idx)   # how many lines were removed
}

# --- 5. the safety guard ---------------------------------------------------

function Get-PlaybookBodyLines([string]$CacheGigaPath) {
    # The live, private Playbook, straight from the cache. This is the thing we
    # are making sure never lands in the repo.
    $lines = (Read-Text $CacheGigaPath) -split "`r?`n"
    $idx = -1
    for ($i = 0; $i -lt $lines.Count; $i++) {
        if ($lines[$i] -match '^##\s+Playbook') { $idx = $i; break }
    }
    if ($idx -lt 0) { return @() }
    return $lines[$idx..($lines.Count - 1)]
}

function Get-SignificantLines([string[]]$Lines) {
    # Strip markdown scaffolding, keep only lines long enough to be distinctive.
    # Short fragments would collide with ordinary skill prose and cause the kind
    # of false positive that made the old word-list guard unusable.
    $out = New-Object System.Collections.Generic.List[string]
    foreach ($l in $Lines) {
        $t = $l -replace '^[\s>#*\-\+\d\.\|]+', ''
        $t = $t -replace '[\s\|]+$', ''
        $t = $t.Trim()
        if ($t.Length -ge 40 -and $t -match '[a-zA-Z]') { [void]$out.Add($t) }
    }
    return $out
}

function Get-ForbiddenStrings([string]$Path) {
    if (-not (Test-Path $Path)) { return @() }
    return @(Get-Content -LiteralPath $Path |
             Where-Object { $_.Trim() -ne '' -and -not $_.TrimStart().StartsWith('#') } |
             ForEach-Object { $_.Trim() })
}

function Test-Safety([string]$Root, [string]$Cache) {
    $problems = New-Object System.Collections.Generic.List[string]

    # -- A. giga/SKILL.md must be correctly truncated ----------------------
    $gigaPath = Join-Path $Root 'skills\giga\SKILL.md'
    $gigaText = Read-Text $gigaPath
    $gigaLines = $gigaText -split "`r?`n"

    $markers = @(0..($gigaLines.Count - 1) | Where-Object { $gigaLines[$_] -match '^##\s+Playbook' })
    if ($markers.Count -ne 1) {
        $problems.Add("A: expected exactly one '## Playbook' heading in skills/giga/SKILL.md, found $($markers.Count).")
    } else {
        $tail = @($gigaLines[$markers[0]..($gigaLines.Count - 1)] |
                  Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
        $want = @($PlaceholderLines | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
        if (($tail -join "`n") -ne ($want -join "`n")) {
            $problems.Add("A: the Playbook section of skills/giga/SKILL.md is not the approved placeholder. The strip step did not do what it should have.")
        }
    }

    # -- B. no live Playbook content anywhere in the repo -------------------
    $pbLines = Get-SignificantLines (Get-PlaybookBodyLines (Join-Path $Cache 'giga\SKILL.md'))
    if ($pbLines.Count -eq 0) {
        $problems.Add("B: could not read any Playbook content from the cache to check against. Refusing to certify the repo as clean.")
    }

    # The tripwire list itself obviously contains the tripwire strings.
    $selfPath = Join-Path $Root 'tools\forbidden-strings.txt'
    $files = @(Get-RepoTextFiles $Root | Where-Object { $_.FullName -ne $selfPath })
    foreach ($f in $files) {
        $hay = Read-Text $f.FullName
        foreach ($needle in $pbLines) {
            if ($hay.Contains($needle)) {
                $rel = $f.FullName.Substring($Root.Length).TrimStart('\')
                $n = ($hay.Substring(0, $hay.IndexOf($needle)) -split "`n").Count
                $snip = if ($needle.Length -gt 60) { $needle.Substring(0,60) + '...' } else { $needle }
                $problems.Add("B: Playbook content found in $rel line $n -> `"$snip`"")
                break
            }
        }
    }

    # -- C. literal tripwires ----------------------------------------------
    $forbidden = Get-ForbiddenStrings (Join-Path $Root 'tools\forbidden-strings.txt')
    foreach ($f in $files) {
        $hay = Read-Text $f.FullName
        foreach ($needle in $forbidden) {
            if ($hay.Contains($needle)) {
                $rel = $f.FullName.Substring($Root.Length).TrimStart('\')
                $n = ($hay.Substring(0, $hay.IndexOf($needle)) -split "`n").Count
                $problems.Add("C: forbidden string `"$needle`" found in $rel line $n")
            }
        }
    }

    return $problems
}

# --- 6. git ----------------------------------------------------------------

function Initialize-Git {
    $gitCmd = 'C:\Program Files\Git\cmd'
    if (Test-Path (Join-Path $gitCmd 'git.exe')) {
        if ($env:Path -notlike "*$gitCmd*") { $env:Path = "$gitCmd;" + $env:Path }
    }
    if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
        Fail "git.exe not found. Expected it at '$gitCmd\git.exe'."
    }
    # Never sit on a credential prompt during an unattended run.
    $env:GIT_TERMINAL_PROMPT = '0'
    $env:GCM_INTERACTIVE = 'Never'
}

function Invoke-Git {
    # git writes ordinary warnings (line endings, detached head, ...) to stderr.
    # Under $ErrorActionPreference='Stop' those would abort the run, so stderr is
    # captured and kept separate here, and success is judged by the exit code.
    param([Parameter(Mandatory = $true)][string[]]$GitArgs)

    $prev = $ErrorActionPreference
    $ErrorActionPreference = 'Continue'
    try {
        $raw  = & git -C $RepoRoot @GitArgs 2>&1
        $code = $LASTEXITCODE
    } finally {
        $ErrorActionPreference = $prev
    }

    $isErr  = { $_ -is [System.Management.Automation.ErrorRecord] }
    $stdout = @($raw | Where-Object { -not (& $isErr) } | ForEach-Object { [string]$_ })
    $stderr = @($raw | Where-Object { & $isErr }        | ForEach-Object { [string]$_ })

    return [pscustomobject]@{ Out = $stdout; Err = $stderr; Code = $code }
}

function Invoke-GitChecked {
    param([Parameter(Mandatory = $true)][string[]]$GitArgs, [string]$What)
    $r = Invoke-Git $GitArgs
    if ($r.Code -ne 0) {
        $why = if ($r.Err.Count -gt 0) { ($r.Err -join ' | ') } else { "exit code $($r.Code)" }
        Fail "$What failed: $why"
    }
    return $r
}

function Assert-NothingIgnoredStaged {
    $staged = (Invoke-Git @('diff','--cached','--name-only')).Out
    if ($staged.Count -eq 0) { return }
    $ignored = @()
    foreach ($f in $staged) {
        $c = Invoke-Git @('check-ignore', $f)
        if ($c.Code -eq 0 -and $c.Out.Count -gt 0) { $ignored += $f }
    }
    if ($ignored.Count -gt 0) {
        Fail ("staged files are matched by .gitignore: " + ($ignored -join ', ') + ". Nothing was pushed.")
    }
}

function Get-ChangedSkills([string[]]$StagedNames) {
    return @($StagedNames |
        Where-Object { $_ -like 'skills/*' } |
        ForEach-Object { ($_ -split '/')[1] } |
        Sort-Object -Unique)
}

# --- main ------------------------------------------------------------------

$result = [ordered]@{ status = 'unknown'; detail = '' }

try {
    Initialize-Git

    if (-not (Test-Path (Join-Path $RepoRoot '.git'))) { Fail "'$RepoRoot' is not a git repository." }

    $cache = Find-SkillsCache
    Write-Verbose "cache: $cache"
    Assert-CrewPresent $cache

    $skillsDir = Join-Path $RepoRoot 'skills'
    if (-not (Test-Path $skillsDir)) { New-Item -ItemType Directory -Path $skillsDir -Force | Out-Null }

    foreach ($s in $CrewSkills) { Sync-SkillFolder $cache $skillsDir $s }

    $stripped = Remove-Playbook (Join-Path $skillsDir 'giga\SKILL.md')
    Write-Verbose "stripped $stripped Playbook lines from giga/SKILL.md"

    $problems = Test-Safety $RepoRoot $cache
    if ($problems.Count -gt 0) {
        Fail ("safety scan failed with $($problems.Count) finding(s):" + [Environment]::NewLine +
              '  ' + ($problems -join ([Environment]::NewLine + '  ')))
    }
    Write-Verbose "safety scan clean"

    Invoke-GitChecked @('add','-A') 'git add' | Out-Null
    Assert-NothingIgnoredStaged

    $pending = (Invoke-Git @('diff','--cached','--name-only')).Out
    if ($pending.Count -eq 0) {
        $result.status = 'no-change'
        $result.detail = 'skills already match the cache'
        Write-Output 'NO CHANGE - skills already match the cache; nothing committed.'
        return
    }

    $changed = Get-ChangedSkills $pending
    $msg = if ($changed.Count -gt 0) { 'Sync crew skills: ' + ($changed -join ', ') }
           else { 'Sync repo tooling' }

    if ($DryRun) {
        $result.status = 'dry-run'
        $result.detail = "$msg ($($pending.Count) file(s))"
        Write-Output "DRY RUN - would commit: $msg"
        $pending | ForEach-Object { Write-Output "    $_" }
        Invoke-Git @('reset') | Out-Null
        return
    }

    Invoke-GitChecked @('commit','-m',$msg) 'git commit' | Out-Null
    Invoke-GitChecked @('push') 'git push' | Out-Null

    $head = (Invoke-Git @('rev-parse','--short','HEAD')).Out[0]
    $result.status = 'pushed'
    $result.detail = "$msg ($($pending.Count) file(s), $head)"
    Write-Output "PUSHED $head - $msg"
    $pending | ForEach-Object { Write-Output "    $_" }
}
catch {
    $result.status = 'abort'
    $result.detail = $_.Exception.Message
    Write-Output $_.Exception.Message
    exit 1
}
finally {
    $stamp = (Get-Date).ToString('yyyy-MM-dd HH:mm:ss')
    $flat  = ($result.detail -replace "`r?`n", ' | ')
    Add-Content -LiteralPath (Join-Path $RepoRoot 'sync.log') -Value "$stamp  [$($result.status)]  $flat"
}
