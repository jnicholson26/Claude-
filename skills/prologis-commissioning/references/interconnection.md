# Interconnection — the pre-energization window

## Why this is its own reference

Rev 1.00 §1.1.1 says it plainly: on a supply-side connection, equipment "will remain energized and will be unsafe to inspect during the rest of the cold commissioning procedure." Once the facility or circuit is re-energized, the window closes. Missing one of these tests means another outage, another coordination cycle with the utility and the tenant, and a schedule hit that dwarfs the cost of the test itself.

So interconnection is not a form to fill in later. It is a capture that has to happen on the day, in a specific order, and the paperwork has to be built to make that easy rather than to be reconstructed afterward.

## Before any work happens

Rev 1.00 requires a safety plan and Method of Procedure submitted to the Owner and **approved by both the OE and the Owner prior to any work**, with commissioning activities included in the plan. This is a gate, not a deliverable — work performed before approval is work Prologis can decline to accept.

Capture:

- Safety plan document
- Method of Procedure document
- OE approver name and approval date
- Owner approver name and approval date
- Confirmation that commissioning activities are included in the MOP

None of this lives in Scoop today. It lives in email and SharePoint, which means a fill task has to go fetch it. If it does not exist, that is a finding worth raising before the crew mobilizes, not after.

## The five tests, before re-energization

Rev 1.00 lists these "at a minimum before the facility or circuit is re-energized." Forms are in Appendix 4.

| # | Test | Form | The thing usually missed |
|---|---|---|---|
| 1 | Insulation resistance of AC feeders | AC Feeder IR (Appendix 4) | The four neutral readings. Prologis wants ten per feeder: A-B, B-C, A-C, A-N, B-N, C-N, A-Gnd, B-Gnd, C-Gnd, N-Gnd. Scoop captures six. |
| 2 | Witness before concealment: crimping tools and procedure | Visual Inspection WBC (Appendix 4) | This is the crimping check specifically, and it has to happen **before heat or cold shrink is applied**. Irreversible — see below. |
| 3 | Torque verification of termination hardware | Electrical Torque (Appendix 4) | Conductor ID / set. Parallel sets each need their own row, and on mechanical lugs both the Allen set screw and the mounting bolt get recorded. |
| 4 | Ground resistance, main ground bar to AC disconnect | Ground Continuity (Appendix 4) | This specific point-to-point reading. Scoop measures resistance at the panelboard and nothing else, so this one is almost always absent. |
| 5 | CT and PT installation verified via metering verification | Ground Continuity / metering forms | Ties the interconnection package to the DAS and metering forms. See below. |

Compression fitting inspection (Appendix 4) also belongs to this window whenever terminations are being made.

## CT and PT verification

The most under-specified of the five, and the one that connects interconnection to the metering forms. What Prologis wants confirmed:

- CT manufacturer, model, catalog number, ratio
- PT / VT wiring configuration matches the plan set (wye, wye grounded, etc.)
- Programmed CT/PT ratios match installed hardware, verified by the electrician
- CTs installed facing the same direction — **photo required**
- CTs centered and mounted at right angles to conductors
- CT shorting pins disengaged after installation
- Voltage taps and CT phases correctly aligned and color-coded

Scoop covers roughly half of this in its meter block, and records the wrong identifiers: the meter fields have been observed holding the DAS enclosure part number and the gateway serial rather than the meter's own. Pull identifiers from the equipment schedule on the DAS drawings, not from free text.

## Gear identification and the scope question

Capture the gear itself, because it decides who owns the testing:

- Manufacturer, serial number, model number
- NEMA rating, KAIC/RMS, amps, voltage
- Interconnection type: line side, load side, or breaker
- **New or existing equipment**

That last field matters more than it looks. On a line-side tie the switchgear belongs to the building. MBL did not install it. Testing obligations on existing gear — ground fault protection especially — may not be MBL's at all. That is a contract question for the program manager, not something a field tech resolves with an N/A checkbox. Record it as **out of scope** and escalate.

Also capture whether a third-party UL re-certification was performed and its report obtained. MBL's own PCC datasheet notes that a third-party UL report "may be provided in lieu of other supporting documents for this form," which makes it a genuinely useful substitute when it exists.

## Sequencing

Capture in this order, because each step forecloses the next:

1. MOP and safety plan approved. Nothing starts before this.
2. Gear identified and photographed with covers off, before any work.
3. Crimps made — **stop and document before shrink goes on.** Compression fitting form completed here.
4. Terminations torqued and witness-marked. Torque form completed.
5. AC feeders meggered, before landing. IR form completed.
6. Ground bar to AC disconnect resistance measured.
7. CTs and PTs installed, oriented, photographed, ratios verified.
8. Covers on, re-energize.

Steps 3 through 6 are the irreversible ones.

## The compression fitting problem

Prologis wants, per conductor location: number of crimps, OEM required crimp count, compression value in pounds, and resistance in ohms — plus lug make and model, die make, model, calibration date and cal due, and five pre-test checks. One of those checks is "no heat shrink has been applied between connectors."

MBL currently captures **one field** for all of this: a free-text box on the PCC sheet reading "All Wire mechanical and/or compression attachments have been checked." The paper Cx workbook has no compression form either. So this is a genuine build, not a modification.

### For sites already terminated

The crimp count and die verification cannot be recovered without cutting a termination apart. Do not fabricate them and do not leave the form blank. Assemble a substitute package and offer it explicitly as a substitute:

- **Resistance across the finished connection**, measured with a digital low resistance ohmmeter. This is the strongest single piece — a good micro-ohm reading demonstrates the connection is sound even when the crimp count is no longer observable.
- **Tool records**: the crimper's calibration certificate and die set for the period the terminations were made. Establishes tool compliance even without per-connection entries.
- **Thermography under load**, which is already required for hot commissioning. A bad crimp runs hot, so a clean IR image at proper irradiance is corroborating evidence at no extra cost.
- **Third-party UL re-certification report**, where one exists.

Present this as a documented substitute with the reason stated, not as a completed form. Prologis can accept or reject it, but they can only do that if they can see what happened.

### Going forward

This is a field process change more than a software change. Someone has to stop at the moment of crimping and document before shrink. Building the form without changing the sequence produces an empty form. Say that out loud when specifying the build.

Two things to confirm with the field lead before promising anything: whether the crew carries a DLRO, and who is actually making the terminations. If a subcontractor crimps, this belongs in their scope and their paperwork.
