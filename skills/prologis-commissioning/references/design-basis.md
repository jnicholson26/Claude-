# Design basis — the nine questions

Answered once per site off the approved drawings, before anyone mobilizes. Each answer either shows a form or writes its N/A with the drawing sheet cited. Record the sheet number with every answer; an N/A without a citation is just a blank with a story.

Scoop already does this correctly in exactly one place: hot form field `7.6 Is there a Transformer Installed?`. That is the pattern.

| Q | Question | Source | What it gates |
|---|---|---|---|
| 1 | Is ground fault protection equipment shown on the approved electrical SLD? | Electrical one-line | §1.1.7 Ground Fault Injection Test, entire form |
| 2 | System voltage | Electrical one-line | §1.1.12 MV Cable VLF, §1.1.13 Transformer Cx |
| 3 | Is a transformer installed? | Electrical one-line | §1.1.13, transformer IR imaging, transformer ground photos |
| 4 | Combiner / recombiner count | Electrical one-line | §1.1.5 DC Feeder (Combined) IR, combiner IR imaging and photos |
| 5 | Is MLPE present, and make/model? | Equipment schedule | Waives §1.1.11 I-V Curve **and** makes §2.1.2 MLPE Mapping mandatory |
| 6 | Which meters are on the design? | DAS drawings | §3.1.2 production, §3.1.3 consumption, §3.1.4 grid |
| 7 | Which weather sensors are on the design? | DAS drawings + location BOM | Which weather checks appear in §3.1.1 |
| 8 | Is underground or foundation work in scope? | Civil / site plan | §1.1.9 trench, foundation and canopy groups |
| 9 | Interconnection type (supply/line side, load side, breaker) | Electrical one-line | §1.1.1 form set, and whether a MOP is required before work |

## Worked answers — Hayward cluster

From `SO128032 Rev 2` (AlsoEnergy DAS drawings, Hayward 9) and the Prologis for-construction set:

- **Q2 System voltage**: 480 V. MV VLF and transformer commissioning both N/A.
- **Q3 Transformer**: none indicated. N/A.
- **Q4 Combiners**: zero. Single string inverter, four strings. DC feeder combined IR N/A.
- **Q5 MLPE**: SolarEdge optimizers present. I-V curve waived, MLPE mapping required.
- **Q6 Meters**: production (Elkor Mark II W2-E4-5A-DL, 250:5 CT) and consumption (Elkor Mark II W2-M1-RC-DL, Rogowski). **No grid meter** — grid meter form N/A per sheet WT101.
- **Q7 Weather sensors**: POA pyranometer (Hukseflux SR100-D1) and back-of-module temperature (IMT Tm-RS485-MB) only. **No GHI, no ambient, no wind speed, no wind direction, no rain, no soiling, no BPOA.** Every DAS check referencing those sensors is N/A per sheets WT101 and WT680.
- **Q8 Underground work**: none, rooftop. Trench and foundation groups N/A. The crimping witness item still applies via §1.1.1.
- **Q9 Interconnection**: line side. MOP required before work.
- **Q1 GFPE**: open. Requires one look at the electrical for-construction set. Gear is 480 V / 1000 A, so NEC 2023 230.95(C) is in play and the question deserves a real answer rather than an assumption either way.

Note on the pyranometer: the Hukseflux SR100-D1 is ISO 9060 **spectrally flat Class B**, which is the post-2018 successor to "first class." Rev 1.00's DAS checklist uses pre-2018 wording ("first class or secondary standard"). Document the equivalence rather than leaving the box unticked.

## The four dispositions

A blank has four possible meanings and they are not interchangeable. Conflating them is the most common way a package goes wrong, because "N/A" is the disposition that closes an item permanently and it gets applied to things that are merely undone.

**N/A — not on the plans.** Permanently closed. Reason and sheet cited. Decided upstream from the drawings, never by a tech in the field.

**Open — on the plans, not installed yet.** The transformer is coming; the meter is not set. Package cannot close. Needs a return trip. Track owner and target date.

**Open — installed, but no instrument or no witness available.** Same disposition, different fix. No test set on the truck, torque wrench out of calibration, only one tech on site so no witness. Worth watching for a pattern: repeated "no calibrated instrument" is a truck-stock problem, not a commissioning problem.

**Out of scope — installed, but it isn't ours.** Existing house gear on a line-side tie. MBL did not install it and the testing obligation may sit with the owner or utility. Escalate to the program manager as a contract question. Never silently N/A this, because it becomes MBL's problem the moment Prologis asks who tested it.

The field tech never selects "N/A." The available answers are what they actually observed: *not installed*, *no instrument available*, *no witness available*, *existing equipment, not in our scope*. Keeping that separation is what stops every hard test from eventually becoming N/A.
