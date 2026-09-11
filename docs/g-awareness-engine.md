# G Awareness Engine (Phase 1)

What G looks at every morning, what counts as a problem, and what it does about it.
Built and validated against live Smartsheet data on 2026-09-10.

## 1. The one workspace

Everything G watches lives in one place: PLD/MBL Shared Workspace, id `1519903262959492`.
Connect as the MBL account (jason@mbl-energy.com). The Trio Advisory login sees different
sheets and produces 403s that look like a permissions bug.

Master sheets (read every sweep):

| Sheet | ID | What it carries |
|---|---|---|
| 01 Pipeline Plan - MBL | 7461778380246916 | 83 project rows, 77 columns. Interconnection status, work order gates, site inspection |
| 03 RFI Log - MBL | 4084078659719044 | 141 RFIs. Status Open/Closed, Ball In Court |
| Change Order Tracker - MBL | 761105830858628 | 45 COs. Status: MBL's Court / PLD Court / Submitted in DocuSign / Executed |
| E2/MBL Observations & Punch List | 3933777693724548 | 1,678 rows, all E2 sites in one sheet |
| Trio/MBL Observations & Punch List | 657484835409796 | Same shape, Trio sites |
| 02a Drawing Reviews - Trio/MBL | 6679624801013636 | Trio drawing review cycle |
| 02b Drawing Reviews - E2/MBL | 2255740177698692 | E2 drawing review cycle |
| 04b BESS Milestone/Closeout | 6335878473404292 | BESS closeout |

Per-site folders (read metadata every sweep, contents on demand):

- AM Handoff, folder id `408815934957444` — 57 AMHO sheets, one per site
- Project Document Trackers, folder id `3596697545795460` — 57 doc trackers, one per site

## 2. What is actually alive, and what is not

This is the part the original architecture got wrong, so it is written down first.

Alive. Rules can be built on these.

- RFI Log status and Ball In Court. Maintained. 8 open of 141 today.
- Interconnection Status on the Pipeline Plan. Maintained. 81 of 83 rows populated.
- Site Inspection Status. Maintained. 81 of 83 "Visited".
- Change Order Status. Maintained. 45 of 45 populated.
- Punch list Status and Response columns. Messy but real, and updated this week.
- Sheet `modifiedAt` timestamps on all 114 per-site sheets. Free, and the cheapest
  staleness signal available.

Dead. Do not build rules on these, and do not report on them as if they mean something.

- AMHO row-level checkboxes. Bayside 13 AMHO is 146 rows and every one of
  EPC Upload Complete, Owner's Rep Verification, PLD Approved and AM Verified is blank.
  The AMHO sheets are scaffolding, not a live record.
- Customer Site Walk (60-days to Mob) and Pre-Mob Meeting (30-days to Mob) on the
  Pipeline Plan. Blank on all 83 rows.
- Owner's Engineer on the Pipeline Plan. Blank on 76 of 83.

G reports the dead columns once, as a coverage gap, and then shuts up about them until
they start moving. It never infers "on track" from a blank cell.

## 3. Detection rules

Each rule has a source, a threshold, a severity and a stated action. G runs all of them
in the morning sweep and reports only what fires.

### R1. Open RFI with no ball in court
Source: RFI Log, Status = Open, Ball In Court blank.
Severity: red. Nobody owns it, so nobody is working it.
Action: name the RFI and the site, propose an owner, offer to set Ball In Court.

### R2. Open RFI sitting in MBL's court
Source: RFI Log, Status = Open, Ball In Court contains "MBL".
Severity: amber at 7 days since last sheet modification, red at 14.
Action: list them oldest first. These are MBL's homework, not Prologis's.

### R3. Change order stalled in PLD's court
Source: Change Order Tracker, Status = PLD Court.
Severity: amber. Red when the count grows or an individual CO passes 30 days.
Action: report the count and the total dollar value, and offer to draft the nudge to
Joe or Joseph. MBL has done its side when Word File Uploaded is checked.

### R4. Interconnection deficiency
Source: Pipeline Plan, Interconnection Status = "Application Deficiency" or
"Approved, Upgrade Required".
Severity: red for deficiency, amber for upgrade required.
Action: name the site and the utility. A deficiency blocks everything downstream.

### R5. Punch list item open but already answered
Source: E2 and Trio punch lists, Status = Open while the Response column reads
Closed, closed, Resolved or similar.
Severity: amber, but this is the highest-volume finding in the data.
Action: batch them by site. These are items MBL has actually fixed that still read as
open to the owner's engineer, and they are what makes a closeout look worse than it is.

### R6. Critical or Major punch item open with no response at all
Source: punch lists, Severity = Critical or Major, Status = Open, Response blank.
Severity: red for Critical, amber for Major.
Action: name site and item. These are the ones that bounce a package.

### R7. Stale site sheet
Source: `modifiedAt` on the 57 AMHO sheets and 57 doc trackers.
Threshold: 30 days with no edit while the site is not closed.
Severity: amber at 30 days, red at 90.
Action: list the site and the last-touched date. Sites whose trackers have not moved
since March are either finished and unmarked or genuinely dropped, and G says which
it cannot tell.

### R8. Coverage gap
Source: any master-sheet column that is blank across more than 80 percent of rows.
Severity: informational, reported weekly not daily.
Action: name the column and the percentage. This is how the dead-signal list above
stays current instead of going stale in a document.

### R9. Commissioning handoff waiting
Source: Scoop workflow stage "Send to Bodie", plus Chase's SharePoint Bodie folder.
Severity: amber after 3 days with no cold approval.
Action: route to Bodie. This rule stays dormant until the commissioning form tests at
100 percent.

## 4. The morning brief, in order

G leads with what needs a decision and puts the reassuring parts last. Nothing over one
screen. If a section has nothing in it, the section does not appear.

1. Needs you today. Red findings only, each one line, each with the action G proposes.
2. In your court. R1 and R2. What MBL owes and to whom.
3. In their court. R3 and anything waiting on Prologis, E2 or Trio, with days waiting.
4. Moving. What changed since yesterday across the master sheets.
5. Quiet too long. R7, capped at the five worst.
6. What I could not see. Connectors that failed, sheets that 403'd, rules that could not
   run. Never omitted, never softened.

Weekly, on Monday, add:

7. Coverage. R8 output, plus whether last week's red items actually closed.

## 5. Cost of a sweep

The whole thing is 8 to 10 tool calls. Two folder listings cover 114 sheets by metadata
alone, which is what keeps this cheap enough to run daily:

- 1 browse_workspace
- 2 browse_folder (AM Handoff, Project Document Trackers) for all 114 modifiedAt values
- 3 filtered get_sheet_summary (RFI Log open, Change Orders not Executed, Pipeline Plan
  deficiencies)
- 2 get_sheet_aggregates (punch lists, grouped by Status and Severity)
- 1 to 2 targeted reads only when a rule fires and G needs the detail

Never read all 114 per-site sheets in a sweep. Never pull the punch lists unfiltered;
E2 alone is 1,678 rows and will eat the context before the brief is written.

## 6. Routing

G decides, then hands off. The rule is who the work belongs to, not who is free.

| Finding | Goes to |
|---|---|
| RFI or change order needing a written reply | G drafts, Jason sends |
| Anything Prologis spec, form, or closeout | Bodie |
| "How should this be set up in Scoop/Pipedrive/Smartsheet" | Frack |
| "Go get this and put it there" — bulk updates, data entry, syncing | Frick |
| Anything a person other than Jason asked for | Watt |

G passes the task, not Jason's context. That wall does not move.

## 7. Live dry run, 2026-09-10

The rules were run against real data the day they were written. What fired:

- R1: 2 open RFIs with no ball in court. RFI 132 "Outdoor AC Disconnect Top Conduit
  Entry" at Hayward 9, and RFI 28 "(Spec 5.13) Helioscope modeling required inputs" at
  Bayside 15. RFI 132 is one of the two items Jason already considers a live dispute,
  and it is sitting unassigned.
- R2: 6 open RFIs in MBL's court. Hayward Commerce CTR 01, Bayside 24, Hayward 12,
  Bayside 36, Bayside 39, San Leandro 1.
- R3: 43 of 45 change orders sitting in PLD Court. Only 2 executed. All 45 have MBL's
  Word file uploaded, so MBL's side is done on every one of them.
- R4: 2 sites at Application Deficiency, 5 at Approved with upgrade required.
- R5 and R6: fire heavily on the E2 punch list. Repeated pattern of Status Open with a
  response of "closed", plus one Critical open item, "Telehandler - No operators
  license" at San Leandro 20, whose response says closed but whose status never moved.
- R7: at least 8 project document trackers untouched since March 2026.

That is the proof the engine works on live data rather than on a template.
