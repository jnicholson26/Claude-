# Solar Jarvis: Architecture and Build State

Last revised 2026-09-10, after Phase 1 was built and run against live data.

## Vision

G is Jason's personal AI command center for MBL Energy operations. It is the smartest AI
he has access to, it orchestrates the specialized agents, and it runs his projects with
proactive awareness rather than waiting to be asked.

G and Giga are the same thing. Giga is the skill; G is what Jason calls her. There is no
separate meta-layer to build above her, and building one would just split the memory in
two. Everything below lands in the Giga skill.

End goal is unchanged: people see what G does and say "I didn't know we could do that."

## Agent hierarchy, as of 2026-09-09

```
G / Giga (personal, Jason only)
│  Orchestrator. Full context. Makes the judgment calls.
│  Private Playbook that no other agent reads.
│
└─ puts work on the crew, which reports to Watt
   ├─ Watt   — MBL's company-wide chief of staff
   ├─ Bodie  — Prologis, commissioning, closeout. Unproven, scoped to commissioning
   ├─ Frack  — software SME: Scoop, Pipedrive, Smartsheet, how it all connects
   └─ Frick  — the legs: fetch data, load it where it belongs, bulk updates
```

The crew are company assets now. G directs them for Jason's work and passes the task
without passing his context. That wall is not negotiable and is written into the skill.

## What G actually sees

One Smartsheet workspace carries the whole operational picture: PLD/MBL Shared Workspace,
id `1519903262959492`, as the MBL account. Eight master sheets, 57 AM Handoff sheets, 57
project document trackers, 83 project rows on the pipeline plan.

Plus: the memory files, the project docs, Outlook and Google calendar and mail, SharePoint
and Teams (read-only until M365 write consent lands), the browser for Scoop and Pipedrive,
and Jason's computer when a task needs it.

## The correction Phase 1 forced

The original plan assumed the trackers were full of live status and that G could read risk
off milestone columns. They are not, and it cannot.

Verified against live data on 2026-09-10:

- Bayside 13 AMHO has 146 rows. Every EPC Upload Complete, Owner's Rep Verification,
  PLD Approved and AM Verified cell is blank. The AMHO sheets are scaffolding.
- Customer Site Walk and Pre-Mob Meeting on the pipeline plan are blank on all 83 rows.
- Owner's Engineer is blank on 76 of 83.

What is maintained and can carry real rules: RFI status and ball in court, interconnection
status, site inspection status, change order status, the punch lists, and the `modifiedAt`
timestamp on all 114 per-site sheets.

So the awareness engine is built on the live signals, reports the dead columns once as a
coverage gap, and never reads a blank cell as "on track." That distinction is the
difference between a system Jason trusts and one that quietly reassures him.

## Phase 1 — Foundation and awareness. Built 2026-09-10.

- [x] Data sources mapped and sheet IDs locked in
- [x] Live signals separated from dead ones, with evidence
- [x] Nine detection rules written with sources, thresholds and actions (R1-R9)
- [x] Briefing template and section order defined
- [x] Awareness engine written into the Giga skill
- [x] Full spec saved as `claude/g-awareness-engine.md`
- [x] Scheduled sweep created: weekdays 5:00am Pacific, writes `claude/g-daily-sweep.md`
- [x] Rules dry-run against live data, findings below

The sweep is read-only and costs 8 to 10 tool calls. It runs ahead of the 6:00am
Follow-Through refresh and the morning brief, and leaves its findings in the project so
the brief reads them instead of redoing the work.

### What the first live run found

- Two open RFIs with nobody in the court. RFI 132 at Hayward 9 (outdoor AC disconnect top
  conduit entry) and RFI 28 at Bayside 15 (Helioscope modeling inputs). RFI 132 is one of
  the disputes Jason is already tracking, and it is sitting unassigned.
- Six open RFIs in MBL's court: Hayward Commerce CTR 01, Bayside 24, Hayward 12,
  Bayside 36, Bayside 39, San Leandro 1.
- Forty-three of 45 change orders parked in PLD Court. Two executed. All 45 have MBL's
  Word file uploaded, so MBL's side is done on every one of them.
- Two sites at interconnection Application Deficiency, five at Approved with upgrade
  required.
- Heavy firing on the E2 punch list: items whose status still reads Open while MBL's own
  response says closed or resolved, plus one Critical open item at San Leandro 20.
- At least eight project document trackers untouched since March 2026.

None of that came from a template. It came from the sheets.

## Phase 2 — Action and orchestration. Next.

Goal: G stops reporting and starts closing things.

- [ ] Smartsheet writes, starting with the safest and highest-volume case: reconciling
      punch list items whose response says resolved but whose status still says open.
      Batch, show Jason the diff, write on his OK.
- [ ] Ball In Court fills on unowned RFIs, proposed by G and confirmed by Jason.
- [ ] Draft the change order nudge to Joe or Joseph, with the count and the dollars.
      Needs CO Amount parsed; it is a text column, not currency.
- [ ] Delegation routing live: G decides Bodie vs Frack vs Frick vs draft-it-herself.
- [ ] Calendar follow-ups created off sweep findings.
- [ ] Answer the open question the sweep cannot answer alone: which of the 57 sites are
      actually closed. Nothing in the workspace marks completion, so staleness cannot tell
      "finished" from "dropped."

Standing rule that does not change in Phase 2: nothing reaches a customer-facing system
until Jason has reviewed it.

## Phase 3 — Autonomy and learning.

- [ ] Cross-portfolio orchestration across Prologis, E2 and Trio
- [ ] Predictive flagging, three to five days ahead of a blow-up
- [ ] Routine decisions handled without asking
- [ ] The learning loop: corrections and preferences captured to the Playbook the same
      session they happen
- [ ] Stakeholder coordination, drafted by G and sent by Jason

## Dependencies still open

- M365 write consent (`Files.ReadWrite.All`, `Mail.ReadWrite`). Blocks anything filing or
  drafting on MBL's behalf. IT request sent, no admin identified yet.
- Scoop and Pipedrive have no direct connector. Browser only for now.
- The Scoop to Pipedrive handoff trigger is still unfinalized.
- Bodie stays disabled until the Prologis commissioning form tests at 100 percent, which
  keeps R9 dormant.

## How to tell it is working

Phase 1 succeeds when Jason stops opening Smartsheet to find out what is wrong, and the
first thing he reads in the morning already names it. The first run cleared that bar on
the change order backlog alone.

Phase 2 succeeds when the number of items G closes exceeds the number it reports.

Phase 3 succeeds when a problem gets caught before it has a name.
