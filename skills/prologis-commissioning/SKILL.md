---
name: prologis-commissioning
description: Fills out Prologis PV commissioning forms (Rev 1.00, Equipment Functional Testing) from MBL Energy's Scoop field reports, and audits a commissioning package for what is missing before it goes to Prologis. Use this whenever Jason or anyone at MBL mentions a cold or hot commissioning package, a Scoop COLD-CX or HOT-CX report, DAS or metering commissioning, PAT or performance acceptance testing, an interconnection test package, or asks "what are we missing" / "will this pass" / "fill out the Prologis form" for any Prologis site. Also use it when a Scoop commissioning report lands in the inbox and needs to be turned into a Prologis submittal, when someone asks whether a specific test applies at a site, or when reviewing why Prologis or E2 bounced a commissioning package.
---

# Prologis PV Commissioning Forms

MBL Energy is the EPC. Field crews capture commissioning data in **Scoop**, which emails a PDF report from `messages-noreply@scoopapponline.com`. Prologis requires that same work on **their** forms: *PV Commissioning Forms, Equipment Functional Testing, Rev 1.00, issued 5/27/2026*. This skill maps one to the other.

The job is usually one of three things:

1. **Fill** — turn a Scoop report into a completed Prologis form set.
2. **Audit** — tell someone what's missing before it ships.
3. **Scope** — answer whether a given test applies at a given site.

All three run on the same foundation: figure out what the site actually has, then check that against what Rev 1.00 asks for.

## Start with the design basis, always

Nothing else works until you know what equipment is on the approved drawings. This is Jason's rule and it is the organizing principle of the whole package: **if it isn't on the plans, we don't test it — but the N/A has to be recorded, not left blank.** An omission and a documented N/A look identical to a reviewer, and only one of them passes.

Nine questions, answered off the drawings, before touching any form. `references/design-basis.md` has the full list, what each one gates, and the four dispositions that a blank can legitimately have. Read it first on any fill or audit task.

The short version of the four dispositions, because getting these confused is the most common way a package goes wrong:

| Situation | Disposition | Consequence |
|---|---|---|
| Not on the plans | **N/A** with reason and sheet cited | Permanently closed |
| On the plans, not installed yet | **Open** | Package can't close; return trip |
| Installed, no instrument or no witness available | **Open** | Return trip, and a pattern worth noticing |
| Installed, but it's existing equipment we didn't install | **Out of scope** | Contract question, escalate — do not silently N/A |

A field tech never picks "N/A." They record what they saw. The N/A determination comes from the drawings, upstream.

## Filling a form set

1. **Get the Scoop report.** It arrives as an email with an S3 download link, or sits in SharePoint under `Jobs In Progress/Prologis - <Site>/Commissioning/`. Extract the full field list verbatim, including blanks — a field that came through empty is a finding, not something to skip past.
2. **Establish the design basis** from the drawings (`1_Drawings and install manuals/For Construction Set` for electrical; the AlsoEnergy `SO*` set for DAS and metering). Record each answer with its sheet number.
3. **Map** using `references/field-map.md`. It goes form by form, naming the Scoop source field ID for everything that exists.
4. **Derive** every pass/fail from the criteria in `references/acceptance-criteria.md` rather than copying the tech's answer. Scoop frequently scores against the wrong threshold, and a copied wrong answer becomes MBL's wrong answer.
5. **Flag, don't fix.** Where Scoop's value is implausible or self-contradictory, put the value in the form and raise it separately. Never silently correct field data — the person who took the reading is the only one who can resolve it.
6. **Report the gaps** grouped by disposition, so the reader knows what needs a truck and what needs a signature.

Two things cannot be filled from Scoop no matter how complete the report is, and saying so up front saves an argument later:

- **Signatures.** Test performer and witness, on nearly every cold form. A signature has to exist in Scoop from the time of test. If it's blank there, it's blank on the Prologis form.
- **Documents that live outside Scoop.** The interconnection MOP approval, the EOR I-V curve waiver, third-party UL reports, calibration certificates. These are in email or SharePoint and have to be fetched.

## Interconnection is a one-shot window

Treat it separately from the rest of cold commissioning, because the opportunity closes. On a supply-side or line-side connection the existing gear stays energized and becomes unsafe to inspect once the facility is re-energized. Rev 1.00 lists five tests that happen *before* re-energization, and if they're missed there is no second chance without another outage.

`references/interconnection.md` covers what to capture, in what order, and the two items most often missed (the ground bar to AC disconnect reading, and CT/PT verification via metering).

The same irreversibility applies to **compression fittings**. One of the pre-test checks is literally "no heat shrink has been applied between connectors." Once shrink is on you cannot count crimps or verify the die. For sites already terminated this data does not exist and cannot honestly be created — `references/interconnection.md` has the substitute package to offer instead, built from resistance readings, tool records, thermography and any third-party UL report.

## Auditing a package

Same first two steps, then walk every form in `references/form-inventory.md` and assign each one: complete, partial, open, N/A, or out of scope. Lead the report with whatever repeats across forms, because those are what actually bounce a package — a missing witness block fails eleven forms at once, and reporting it eleven times buries the point.

When you find contradictions inside the report itself, say so plainly. Common ones, all observed in real MBL submittals: a "photos uploaded: Pass" checkbox above empty photo slots; a pass/fail word sitting in a field labelled with a unit; an inverter marked "In Progress" on a report certifying readiness for energization; an N/A test whose review block still certifies that its reports were uploaded in full.

## Tone

The field data is usually good. MBL's torque capture records measured values per phase where Prologis only asks for a checkmark. Gaps here are overwhelmingly form and validation problems, not craft problems, and framing them that way is both accurate and the only way the findings get acted on. Say what's wrong directly, but don't let a form gap read as a criticism of the crew.

Jason's own writing preference applies to anything drafted for him: professional but conversational, no em dashes, no buzzwords, direct.

## Reference files

Read these as the task requires rather than all at once.

- **`references/design-basis.md`** — the nine gating questions, the four dispositions, and worked answers for the Hayward cluster. Read on every task.
- **`references/interconnection.md`** — the pre-energization test set, MOP requirements, CT/PT verification, and the compression fitting problem including the back-catalog substitute package.
- **`references/field-map.md`** — form-by-form Scoop-to-Prologis field mapping with Scoop field IDs.
- **`references/acceptance-criteria.md`** — every threshold in Rev 1.00: NETA insulation resistance, ground continuity, thermal deltas, torque, I-V curve, PAT entry and pass criteria.
- **`references/form-inventory.md`** — all 21 forms with their appendix location and what each one is for.
