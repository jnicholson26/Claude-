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

## Pushing

    git add .
    git commit -m "your message"
    git push
