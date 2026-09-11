# Claude-

Version history for MBL Energy's AI assistants: the crew skills, the Solar Jarvis
architecture, and the AI governance record.

## Read this before you edit anything

This repository is a MIRROR, not the source of truth.

The skills that actually run live in Jason's Claude account. Editing a file here does
not change what Claude does. To change behaviour, edit the skill in Claude and save it,
then mirror the result back here. Treat this repo as history, review and backup.

## What is here

    docs/      Solar Jarvis architecture, and the awareness engine spec (detection
               rules, thresholds, the daily sweep)
    policy/    AI access register: permissions granted, who approved them, what is open
    skills/    The crew. giga, watt, frick, frack, bodie, prologis-commissioning,
               scoop-api-ops
    tools/     The mirror script and its safety guard

## What is deliberately NOT here, and must stay out

Giga's Playbook. It is Jason's private working memory and includes notes on colleagues.
It is stripped from `skills/giga/SKILL.md` in this repo and lives only in the live skill
and one local file. Do not paste it in.

The MBL operating picture. Schedule variance against contract and open change order
values are commercially sensitive while the Prologis matters are live.

Credentials of any kind. Nothing in this repo should ever require a secret to be useful.

`.gitignore` covers all three. Check it before adding files.

## The crew, briefly

    giga     Jason's personal chief of staff. Private to him.
    watt     MBL's company-wide chief of staff.
    bodie    Prologis spec, commissioning forms, closeout.
    frack    Software subject matter expert across Scoop, Smartsheet, Pipedrive.
    frick    Data gathering and loading.

## Syncing

A scheduled task ("Claude repo sync") runs this on weekdays, and you can run it by hand
any time:

    powershell.exe -NoProfile -ExecutionPolicy Bypass -File tools\Sync-Skills.ps1

Add `-DryRun` to see what it would commit without committing. It mirrors the seven crew
skills out of the local Claude skills cache, strips the Playbook, runs the safety guard,
then commits and pushes. Output is one of `PUSHED <sha>`, `NO CHANGE`, or `ABORT: ...`,
and every run appends a line to `sync.log` (local only, gitignored).

### The safety guard

It aborts before staging anything if any of these fail:

  A. `skills/giga/SKILL.md` must end with the exact approved Playbook placeholder, so a
     silent failure of the strip step cannot slip through.
  B. No file here may contain any substantial line of the real Playbook, read live from
     the cache at scan time. This is the main guard and it updates itself as the
     Playbook changes.
  C. No file may contain a string listed in `tools/forbidden-strings.txt` — the backstop
     for private content that has since been edited out of the Playbook but could still
     be sitting in an old file here.

Keep entries in `forbidden-strings.txt` specific. The first version of this guard used
generic phrases like "long-term memory", which also appear in the skills' own
instructional prose, so it fired on every run and blocked the sync.

**An abort is the guard working.** Read what it names, fix the leak at the source, and
run again. Do not loosen the guard to get a push through.

## Pushing by hand

    git add .
    git commit -m "your message"
    git push
