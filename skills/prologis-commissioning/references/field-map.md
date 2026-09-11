# Field map — Scoop to Prologis

Action codes: **HAVE** Scoop already captures it, source named. **MODIFY** the field exists but is the wrong type, unit, criterion, or is aggregated where Prologis wants one row per item. **NEW** nothing corresponds; has to be built. **GATE** a design-basis question, not a field.

Scoop field IDs come from the Hayward 9 COLD-CX, Hayward 12 HOT-CX and Tasman 180 HOT-CX reports. Numbering drifts between Scoop form versions — Hayward 9's cold sections are numbered 6.x while Hayward 12's hot sections are 7.x and Tasman's are 6.x. Match on field label, not number.

## Cold commissioning

### 1.1.1 Interconnection

| Prologis field / check | Scoop source | Action | Repeats per | Note |
|---|---|---|---|---|
| Safety Plan submitted to Owner | — | NEW | Site | Rev 1.00 requires approval BEFORE work starts. Capture doc + approval date + approver. · Approved by OE and Owner prior to any work |
| Method of Procedure (MOP) submitted | — | NEW | Site | Commissioning activities must be included in the plan. · Approved by OE and Owner prior to any work |
| OE approval date | — | NEW | Site |  |
| Owner approval date | — | NEW | Site |  |
| Insulation resistance test of AC feeders | 6.3 block | MODIFY | Feeder | Same form as 1.1.3 but filed under interconnection. · Appendix 4 form |
| Witness before concealment: crimping tools and procedure | — | NEW | Termination | The one WBC item that applies on a rooftop site. · Before heat/cold shrink applied |
| Torque verification of termination hardware | 6.13-6.15 | HAVE | Equipment |  |
| Ground resistance: main ground bar to AC disconnect | — | NEW | Site | Specific point-to-point reading. 6.11 measures the panelboard only. · Ohms |
| CT and PT installation verified via metering verification | — | NEW | Meter | Links to the DAS/metering forms. |

### 1.1.2 Compression Fittings

| Prologis field / check | Scoop source | Action | Repeats per | Note |
|---|---|---|---|---|
| Project Name | 1.1 | HAVE | Site |  |
| Company Performing Test | — | NEW | Test | Global block A. |
| Compression Lug Manufacturer | — | NEW | Test |  |
| Compression Lug Model | — | NEW | Test |  |
| Die Manufacturer | — | NEW | Test |  |
| Die Model | — | NEW | Test |  |
| Die Calibration Date | — | NEW | Test |  |
| Die Cal Due Date | — | NEW | Test | Must be after date of service |
| Conductors are not scored from stripping process | — | NEW | Test |  |
| Antioxidant applied on aluminum conductors prior to crimping | — | NEW | Test |  |
| No heat shrink applied between connectors | — | NEW | Test |  |
| Crimp tool meets minimum specifications | — | NEW | Test | 12 ton, not dieless on certain wire sizes |
| Crimp tool calibration within 1 year of use | — | NEW | Test |  |
| Location of Conductor | — | NEW | Conductor | Repeating row. |
| # of Crimps | — | NEW | Conductor |  |
| OEM Required Crimp Count | — | NEW | Conductor | Validate actual >= required. |
| Compression Value | — | NEW | Conductor | lbs |
| Resistance | — | NEW | Conductor | Ohms |
| Test Performer print / signature / date | 6.8.22 name only | MODIFY | Test | Global block C. |
| Witness print / signature / date | — | NEW | Test | Global block D. |

### 1.1.3 AC Feeder IR

| Prologis field / check | Scoop source | Action | Repeats per | Note |
|---|---|---|---|---|
| Company Performing Test | — | NEW | Test |  |
| Megger Manufacturer | — | NEW | Test |  |
| Megger Model | — | NEW | Test |  |
| Megger Calibration Date | — | NEW | Test |  |
| Megger Cal Due Date | — | NEW | Test | Must be after date of service |
| Ambient Temperature | 6.3.3 (deg F) | MODIFY | Test | Currently 67 recorded in F on a C form. Add unit or convert on output. · deg C |
| Relative Humidity | 6.3.4 | HAVE | Test | % |
| Meter leads continuity verified to zero Ohms | — | NEW | Test |  |
| Conductors correctly phased and identified by continuity check | — | NEW | Test |  |
| Neutrals not landed for testing | — | NEW | Test |  |
| Test Voltage | 6.3.5 | HAVE | Test | Vdc |
| Test Duration | — | NEW | Test | Rev 1.00 preprints 60 sec. Capture it. |
| Acceptable Resistance | — | NEW | Test | Auto-derive from test voltage. 600V class = 100 MOhm min. · MOhm, from NETA 7.3.3 |
| Feeder ID / Location | 6.3.6 (aggregate) | MODIFY | Feeder | Today one row reads '1-6'. Needs one row per feeder. |
| Resistance unit selector | — | NEW | Reading | BLOCKER. Today '2.2' sits in a field labelled MOhm/GOhm. · MOhm or GOhm |
| A-B | 6.3.10 | HAVE | Feeder | MOhm |
| B-C | 6.3.11 | HAVE | Feeder | MOhm |
| A-C | 6.3.12 (as C-A) | HAVE | Feeder | Rename to match Prologis label. · MOhm |
| A-N | — | NEW | Feeder | MOhm |
| B-N | — | NEW | Feeder | MOhm |
| C-N | — | NEW | Feeder | MOhm |
| A-Gnd | 6.3.7 | HAVE | Feeder | MOhm |
| B-Gnd | 6.3.8 | HAVE | Feeder | MOhm |
| C-Gnd | 6.3.9 | HAVE | Feeder | MOhm |
| N-Gnd | — | NEW | Feeder | MOhm |
| Pass / Fail | 6.3.13 (manual) | MODIFY | Feeder | Derive, do not ask the tech. · vs NETA minimum |
| Test Performer print / signature / date | — | MODIFY | Test |  |
| Witness print / signature / date | — | NEW | Test |  |

### 1.1.4 DC String IR

| Prologis field / check | Scoop source | Action | Repeats per | Note |
|---|---|---|---|---|
| Company Performing Test | — | NEW | Test |  |
| Megger Manufacturer / Model / Cal Date / Cal Due | — | NEW | Test | Global block B. · 4 fields |
| Ambient Temperature | 6.5.3 (deg F) | MODIFY | Test | deg C |
| Relative Humidity | 6.5.4 | HAVE | Test | % |
| Conductors correctly labeled and identified by continuity check | — | NEW | Test |  |
| Meter leads continuity verified to zero Ohms | — | NEW | Test |  |
| Test Voltage | 6.5.5 | HAVE | Test | Vdc |
| Test Duration | — | NEW | Test | 60 sec |
| Acceptable Resistance | — | NEW | Test | MOhm |
| Inverter | 6.5.8 | HAVE | String |  |
| String | 6.5.9 (aggregate) | MODIFY | String | Today '1-6' on a site the inverter sheet says has 4 strings. One row per string. |
| Positive - Negative | 6.5.10 | HAVE | String | MOhm |
| Positive - Ground | 6.5.11 | HAVE | String | MOhm |
| Negative - Ground | 6.5.12 | HAVE | String | MOhm |
| Pass Y/N | 6.5.13 | MODIFY | String |  |
| Test Performer + Witness | — | NEW | Test |  |

### 1.1.5 DC Feeder (Combined) IR

| Prologis field / check | Scoop source | Action | Repeats per | Note |
|---|---|---|---|---|
| Applies only if combiner count > 0 | — | GATE | Site | Hayward 9 = 0 combiners. Auto-N/A citing the SLD. · Design Basis Q4 |
| Company Performing Test | — | NEW | Test |  |
| Megger Manufacturer / Model / Cal Date / Cal Due | — | NEW | Test | 4 fields |
| Ambient Temp (deg C) / Relative Humidity (%) | — | NEW | Test | 2 fields |
| Conductors labeled and identified by continuity check | — | NEW | Test |  |
| Meter leads verified to zero Ohms | — | NEW | Test |  |
| Test Voltage / Duration / Acceptable Resistance | — | NEW | Test | 3 fields |
| Combiner | — | NEW | Conductor |  |
| Conductor ID | — | NEW | Conductor |  |
| Positive-Negative / Positive-Ground / Negative-Ground | — | NEW | Conductor | MOhm |
| Pass Y/N | — | NEW | Conductor |  |
| Test Performer + Witness | — | NEW | Test |  |

### 1.1.6 Ground Continuity

| Prologis field / check | Scoop source | Action | Repeats per | Note |
|---|---|---|---|---|
| Company Performing Test | — | NEW | Test |  |
| Ambient Temp / Date of Test | 6.12.1 | HAVE | Test |  |
| Ohmmeter Manufacturer / Model / Cal Date / Cal Due | — | NEW | Test | 4 fields |
| All grounding conductors installed and terminated | — | NEW | Test |  |
| Location ID 1 to ID 2 | 6.11.1 / 6.11.2 single point | MODIFY | Connection | Rev 1.00 wants pairs, not one equipment ID. · point-to-point pair |
| Resistance | 6.11.3 | HAVE | Connection | Ohms |
| Distance Pt to Pt | — | NEW | Connection | Not captured at all today. · ft |
| Pass Y/N | 6.11.4 (25 Ohm) | MODIFY | Connection | BLOCKER: 25 Ohm is the electrode criterion, not continuity. Change to 0.5. · No single bonded connection > 0.5 Ohm |
| Flag if resistance > 1.0 Ohm | — | NEW | Connection | Investigate |
| Flag if bolted connection varies > 50% from peers | — | NEW | Connection |  |
| System group: DC module support structure | — | NEW | Connection | Restore the 3-way split from MBL's own Cx-004. |
| System group: inverter grounding | — | NEW | Connection |  |
| System group: AC system (panelboard, ACDS) | 6.11.1 | HAVE | Connection |  |
| Measured Ground Resistance (Ohms) | 6.10.12 | MODIFY | Site | SCHEMA BUG: this field currently holds the word 'Pass'. Restrict to numeric. |
| Test Performer + Witness | — | NEW | Test |  |

### 1.1.7 Ground Fault Injection

| Prologis field / check | Scoop source | Action | Repeats per | Note |
|---|---|---|---|---|
| Applies only if GFPE appears on the approved SLD | — | GATE | Site | THE PLANS RULE. Check the electrical SLD once. If GFPE is not drawn, permanent N/A with sheet cited. · Design Basis Q1 / NEC 2023 230.95(C) |
| Date of Test / Technician Name / Air Temperature | — | NEW | Test | 3 fields |
| Switchgear Label | — | NEW | Test |  |
| Switchgear Rating | 6.1.10 | HAVE | Test | A |
| Breaker Serial Number | — | NEW | Test |  |
| Breaker Make/Model | — | NEW | Test |  |
| Breaker Current Rating | — | NEW | Test | A |
| Breaker Trip Plug Rating | — | NEW | Test |  |
| Trip Unit Make/Model | — | NEW | Test |  |
| Ground Fault System Type | — | NEW | Test |  |
| Ground Fault Make/Model | — | NEW | Test |  |
| Ground Fault CT Ratio | — | NEW | Test |  |
| GF Trip Settings (As Found) | — | NEW | Test |  |
| GF Trip Settings (As Left) | — | NEW | Test |  |
| GF Trip Settings (As Tested) | — | NEW | Test |  |
| Test Set Manufacturer / Model / Cal Date / Cal Due | — | NEW | Test | 4 fields |
| Test Current (Ramp Up) / Min / Max / Actual / Pass-Fail | — | NEW | Phase | per phase A, B, C |
| Test Current / Max Allowable Trip Time / Actual Trip Time / Pass-Fail | — | NEW | Phase | per phase A, B, C |
| Test Current / Actual Time (No Trip) / Pass-Fail | — | NEW | Phase | per phase A, B, C |
| Neutral-Ground Location | — | NEW | Test |  |
| Neutral-Ground Resistance | — | NEW | Test | min MOhm |
| ACDS GFI Manual Trip Test | 6.1.16 | HAVE | Site | Keep, but it is NOT the injection test. Do not let it satisfy this form. |
| Test Performer + Witness | — | NEW | Test |  |

### 1.1.8.1 Electrical Torque

| Prologis field / check | Scoop source | Action | Repeats per | Note |
|---|---|---|---|---|
| Company Performing Test | — | NEW | Test |  |
| Torque Tool Manufacturer | 6.12.3 (PHOTO field) | MODIFY | Test | Currently a photo slot. Must be text. |
| Torque Tool Model | 6.12.4 (PHOTO field) | MODIFY | Test | Currently a photo slot. Must be text. |
| Torque Tool Calibration Date | 6.12.5 | HAVE | Test |  |
| Torque Tool Cal Due Date | — | NEW | Test | Must be after date of test |
| Calibration Certificate | 6.12.6 (blank) | MODIFY | Test | Field exists, came through empty. Make required. |
| Ensure all circuits are de-energized | — | NEW | Test |  |
| All electrical torqued connections checked | — | NEW | Test |  |
| Impact drivers NOT used | — | NEW | Test | Explicit Prologis prohibition. · PLD developer spec prohibits |
| Equipment ID | 6.13.1 / 6.14.2 / 6.15.2 | HAVE | Equipment |  |
| Conductor ID / Set | — | NEW | Equipment | Rev 1.00 example shows 'Set 1'. Parallel sets each need a row. |
| Criteria (required torque) | 6.13.2 / 6.14.7 / 6.15.7 | HAVE | Equipment | in-lb or ft-lb |
| Measured A / B / C / N / G | 6.13.3-7 / 6.14.8-12 / 6.15.8-12 | HAVE | Equipment | We record measured values; Prologis only asks for an X. We are ahead here. · in-lb |
| Allen set screw torque (mechanical lugs) | — | NEW | Lug | Rev 1.00: set screw torqued first, then mounting bolt. Both recorded. · in-lb |
| Mounting bolt torque (mechanical lugs) | — | NEW | Lug | in-lb |
| Bolt stack documented | — | NEW | Lug |  |
| Hardware grade documented | — | NEW | Lug | Grade 5 / Grade 8 |
| DC string terminations | 6.13.9-11 (0.0) | MODIFY | Inverter | BLOCKER: recorded as 0.0 with note 'Dc do not have torque measures'. Convert to explicit N/A + manufacturer citation. |
| Witness marks installed (paint pen / tamper proof) | 6.13.8 / 6.13.14 / 6.14.13 / 6.15.13 | HAVE | Equipment |  |
| Pull Boxes - grounding | — | NEW | Equipment | Not in Scoop's equipment list today. · Rev 1.00 Table 9 |
| DC Distribution - grounding | — | NEW | Equipment | Not in Scoop's equipment list today. · Rev 1.00 Table 9 |
| Test Performer + Witness | — | NEW | Test |  |

### 1.1.8.2 Mechanical Torque

| Prologis field / check | Scoop source | Action | Repeats per | Note |
|---|---|---|---|---|
| Project Name / Company Performing Test | — | NEW | Test | Entire form is absent from Scoop. · 2 fields |
| Manufacturer / Model / Cal Date / Cal Due | — | NEW | Test | 4 fields |
| Three percent of each type of mechanical connection tested | — | NEW | Test | Prompt the tech with the 3% count from the racking quantity. |
| Location | — | NEW | Connection |  |
| Torque | — | NEW | Connection | ft-lb |
| Pass Y/N | — | NEW | Connection | NETA Table 100.12.1-100.12.4 or mfr spec |
| Test Performer + Witness | — | NEW | Test |  |

### 1.1.9 Witness Before Concealment

| Prologis field / check | Scoop source | Action | Repeats per | Note |
|---|---|---|---|---|
| Trench + foundation groups apply only if underground/foundation work in scope | — | GATE | Site | Rooftop sites: groups auto-N/A. Crimping witness still applies via 1.1.1. · Design Basis Q8 |
| Conduit separation in trench matches plans for DC home runs | — | NEW | Item | Photo link required |
| Conduit separation in trench matches plans for AC | — | NEW | Item | Photo link required |
| Conduit separation in trench matches plans for MV | — | NEW | Item | Photo link required |
| Over excavation and preparation of vaults and pull boxes | — | NEW | Item | Photo link required |
| Locator tape installed | — | NEW | Item | Photo link required |
| Direct bury trench cable transition from conduit, with cover depth measurement reference | — | NEW | Item | Photo link required |
| Direct bury trench with cable exposed | — | NEW | Item | Photo link required |
| Backfill requirements meet engineering specifications | — | NEW | Item | Photo link required |
| Concrete encasement where required | — | NEW | Item | Photo link required |
| Protective coating for metallic raceway where applicable | — | NEW | Item | Photo link required |
| Equipment pad over-excavation and preparation | — | NEW | Item | Photo link required |
| Conduit routing and separation within equipment pad | — | NEW | Item | Photo link required |
| Rebar size and spacing | — | NEW | Item | Photo link required |
| Concrete encased electrode | — | NEW | Item | Photo link required |
| Ground ring depth and any irreversible connections | — | NEW | Item | Photo link required |
| Equipment anchor preparation | — | NEW | Item | Photo link required |
| Spread footing over-excavation and preparation | — | NEW | Item | Photo link required |
| Removal of groundwater prior to concrete pour | — | NEW | Item | Photo link required |
| Caisson rebar structure | — | NEW | Item | Photo link required |
| Equipment ground connection to rebar cage | — | NEW | Item | Photo link required |
| Ufer ground in rebar cage (if applicable) | — | NEW | Item | Photo link required |
| Conduit stub-ups | — | NEW | Item | Photo link required |

### 1.1.10 Inverter DC Input Cx

| Prologis field / check | Scoop source | Action | Repeats per | Note |
|---|---|---|---|---|
| Company Performing Test | — | NEW | Test |  |
| Inverter Make | 6.6.3 | HAVE | Inverter |  |
| Inverter Model | 6.6.3 | HAVE | Inverter | Split make and model into separate fields. |
| Inverter Serial Number | 6.9.2 | HAVE | Inverter |  |
| Grid protection settings | — | NEW | Inverter |  |
| MLPE Make | — | NEW | Site | Also feeds the Design Basis MLPE gate. |
| MLPE Model | — | NEW | Site |  |
| Safety Voltage (per device) | — | NEW | Site | SolarEdge is ~1V per paired optimizer. Drives the expected-value calc. |
| String Length | 6.6.27 | HAVE | String | modules |
| Test meter Manufacturer / Model / Cal Date / Cal Due | — | NEW | Test | 4 fields |
| All conductors correctly labeled, identified, and landed | 6.6.32 | HAVE | Inverter |  |
| Insulation Resistance Testing is complete | — | NEW | Inverter |  |
| Inverter AC circuit is de-energized | — | NEW | Inverter |  |
| Safety Voltage measured | 6.9.x VOC (+ to -) | HAVE | String | V |
| Expected Safety Voltage | 6.9.20 (block 3 only) | MODIFY | String | BLOCKER: present on one test block out of four. Must be on every one, and auto-calculated. · V = string length x per-device V |
| Pass Y/N | — | NEW | String | H9 recorded 25.8V against 50 modules in series. This check catches that. · measured vs expected, within tolerance |
| Polarity Y/N | 6.6.28 | HAVE | String |  |
| Fuse Continuity Y/N/NA | — | NEW | String |  |
| Fuse rating | 6.6.30 | HAVE | String | A |
| VOC + to Ground / - to Ground | 6.9.x | HAVE | String | V, expect 0 |
| Twisted pairs installed | — | NEW | Inverter | Visual verification |
| Daisy chain wiring installed correctly | — | NEW | Inverter | Visual verification |
| Terminating resistor properly installed (if required) | — | NEW | Inverter | Visual verification |
| Inverter Status | 6.6.9 | MODIFY | Inverter | H9 shipped as 'In Progress (Actively being worked)' on a certified-complete report. · Must equal Complete to submit |
| MPPT ID and strings per MPPT | 6.6.24 / 6.6.25 | MODIFY | MPPT | Single values today where the form implies one row per MPPT. |
| DC Output Feeder Size | 6.6.20 | MODIFY | Inverter | H9 recorded #10 AWG, which is string wire, not a feeder. Check the label. |
| Test Performer + Witness | — | NEW | Test |  |

### 1.1.11 I-V Curve Tracing

| Prologis field / check | Scoop source | Action | Repeats per | Note |
|---|---|---|---|---|
| N/A when MLPE present; requires written EOR + manufacturer confirmation | 7.3.7 (hot form) | GATE | Site | Scoop already does this correctly on the hot form. Mirror it here and require the waiver file. · Design Basis Q5 |
| EOR / manufacturer waiver letter | — | NEW | Portfolio | Write once, attach to every SolarEdge site. · Required to close the N/A |
| Analyzer Manufacturer / Model / Cal Date / Cal Due | 7.2.5-7.2.7 | MODIFY | Test | Cal due missing. H12 logged a cal date for an analyzer recorded as 'N/a'. · 4 fields |
| Irradiance at test | 7.2.8 (500 threshold) | MODIFY | Test | Scoop asks >500. Rev 1.00 body says 600. Cold section text says 500. Use 600. · Stable and >= 600 W/m2 per IEC 62446 7.2.3 |
| Device automated report (tabular data + graphs) | 7.3.11 | HAVE | Test |  |
| Fill Factor | — | NEW | String | > 70% |
| Performance Factor | — | NEW | String | >= 95% accept; 90-95 owner acceptance; <90 investigate |

### 1.1.12 MV Cable VLF

| Prologis field / check | Scoop source | Action | Repeats per | Note |
|---|---|---|---|---|
| Applies only if system voltage > 1000V / MV cable present | — | GATE | Site | Hayward 9 is 480V. Auto-N/A. · Design Basis Q2 |
| Technician Name / Test Point of Contact | — | NEW | Test | 2 fields |
| Feeder or Cable Number / Size / Length / Rating / System Voltage | — | NEW | Cable | 5 fields |
| Maximum Test Voltage / Insulation Resistance Test Voltage | — | NEW | Cable | 2 fields |
| Termination Opposite End / Wye Ground or Ungrounded | — | NEW | Cable | 2 fields |
| A Phase B/C to Ground, B Phase A/C to Ground, C Phase A/B to Ground | — | NEW | Cable | 3 fields |
| All MV conductors have appropriate lug or bushing installed | — | NEW | Cable |  |
| All MV conductors un-landed and not connected to equipment | — | NEW | Cable |  |
| Time in Mins / Test kV / Leakage Current Phase A, B, C | — | NEW | Interval | microamps |
| Test Performer + Witness | — | NEW | Test |  |

### 1.1.13 Transformer Cx

| Prologis field / check | Scoop source | Action | Repeats per | Note |
|---|---|---|---|---|
| Applies only if a transformer is installed | 7.6 (hot form) | GATE | Site | Scoop already asks this on the hot form. Reuse the answer. · Design Basis Q3 |
| NETA standard transformer test report | — | NEW | Transformer | Industry standard tests (NETA) |
| kVA rating / primary and secondary voltage / tap position / impact indicator | — | NEW | Transformer | Present on MBL's Cx-000 but not in Scoop. · 4 fields |

### 1.1.14 Cold Cx General Inspection

| Prologis field / check | Scoop source | Action | Repeats per | Note |
|---|---|---|---|---|
| Site, roof, and grounds clear and clean of debris | 7.2 (hot form) | HAVE | Site |  |
| Downspouts, drainage pathways, overflow scuppers not blocked or interrupted | — | NEW | Site |  |
| All anchors, slip sheets, and racking in contact with roof and installed per mfr instructions | 7.24 partial | MODIFY | Site |  |
| Check for cuts, nicks, or damaged cable | — | NEW | Site |  |
| Check for tears or rips on outer jackets of insulation | — | NEW | Site |  |
| Check for missing strands in terminated or torqued conductors | — | NEW | Site |  |
| Check for critical nick indentations at insulation stripping for termination | — | NEW | Site |  |
| Check equipment connectors match | — | NEW | Site |  |
| Check excessive insulation has not been removed | — | NEW | Site |  |
| Check for broken or cracked modules, cells, damaged frames, loose connections, discoloration | 7.8 partial | MODIFY | Site |  |
| Enclosures inspected and free of damage or corrosion | 6.6.10 / 6.6.11 | HAVE | Site |  |
| All conduit entries are sealed | 6.6.17 partial | MODIFY | Site |  |
| Check connections and terminations torqued to specifications | 6.6.33 | HAVE | Site |  |
| Inspect doors, locks, covers operational, clearances met | — | NEW | Site |  |
| Inspect safety and identification labels present and permanently affixed | 6.8.14 / 6.8.17 | HAVE | Site |  |
| Confirm surge protection devices (SPDs) are installed per plan | — | NEW | Site |  |
| Inspect for damage, bends, kinks in racking system | — | NEW | Site |  |
| Verify torque marks present on all bolted connections | 6.8.13 partial | MODIFY | Site |  |
| Verify all PV conductors and optimizer cables secured to racking with owner approved device | — | NEW | Site |  |
| Verify no loose or hanging cables or conductors | — | NEW | Site |  |
| Verify all conductors properly labelled and identified per owner specifications | 6.8.15 / 6.8.16 | HAVE | Site |  |
| Inspect for galvanic corrosion in racking system and components, especially at dissimilar materials | — | NEW | Site |  |
| Inspect for galvanic corrosion in electrical equipment and hardware inside and outside enclosures | — | NEW | Site |  |
| Array is free of shading concerns (notify Prologis if shading is present) | — | NEW | Site |  |
| Verify torque marks on lugs and bolts in subpanels, breakers, disconnects, inverters, racking | 6.8.13 partial | MODIFY | Site |  |
| Certified and calibrated torque screwdriver or ratchet used to test torque marks | — | NEW | Site |  |
| All racking bolts torqued to mfr spec or NETA-ATS Table 100.12.1-100.12.4 | — | NEW | Site |  |
| Paint pen used to make strike marks for torque specifications | — | NEW | Site |  |

## Hot commissioning, DAS and metering, PAT

### 2.1.1 Handheld Thermography

| Prologis field / check | Scoop source | Action | Repeats per | Note |
|---|---|---|---|---|
| Company Performing Test | — | NEW | Test |  |
| Irradiance at time of scan | 7.12.5 / 6.12.5 | MODIFY | Test | HARD FAIL: H12 scanned at 87 W/m2, Tasman at 587. Block the scan below 600. · >= 600 W/m2 |
| Measured equipment output as alternative to irradiance | — | NEW | Test | The only permitted alternative to the 600 W/m2 gate. · >= 50% load |
| System operated approx 30 minutes to allow components to heat | — | NEW | Test |  |
| No faults present on any inverter | 7.1.11 / 7.1.12 | HAVE | Test |  |
| Covers, arc flash guards, dead fronts removed immediately prior to imaging | — | NEW | Test |  |
| Thermal Camera Manufacturer | 7.12.6 | HAVE | Test |  |
| Thermal Camera Model | 7.12.7 | HAVE | Test |  |
| Calibration Date | 7.12.8 | HAVE | Test | Tasman logged cal date = day of test. Validate plausibility. |
| Cal Due Date | — | NEW | Test |  |
| Temperature unit set to Celsius | — | NEW | Test |  |
| Reflected temperature set to 20 deg C | — | NEW | Test |  |
| Emissivity set to 0.95 | — | NEW | Test |  |
| Measurement distance 1 meter | — | NEW | Test |  |
| Ambient Temperature | 7.12.4 / 6.12.4 | MODIFY | Test | H12 recorded 68 and Tasman 79 in a deg C field. Both are Fahrenheit. |
| Circuit Breakers | 7.13 (one block for whole site) | MODIFY | Equipment | Gated off the equipment list. One block per item, not one per site. · Each breaker individually photographed, plus the entire panel view |
| AC/DC Disconnects | 7.13 (one block for whole site) | MODIFY | Equipment | Gated off the equipment list. One block per item, not one per site. · Fuses and terminations |
| AC/DC Fuse Holders | 7.13 (one block for whole site) | MODIFY | Equipment | Gated off the equipment list. One block per item, not one per site. · Fuses and current-carrying bussing |
| Inverters | 7.13 (one block for whole site) | MODIFY | Equipment | Gated off the equipment list. One block per item, not one per site. · AC and DC connections photographed separately |
| Panelboards and switchgear | 7.13 (one block for whole site) | MODIFY | Equipment | Gated off the equipment list. One block per item, not one per site. · All feeder terminations and circuit breakers |
| Transformer terminals | 7.13 (one block for whole site) | MODIFY | Equipment | Gated off the equipment list. One block per item, not one per site. · HV molded T bodies, LV compression terminations |
| Combiner / Recombiner Boxes | 7.13 (one block for whole site) | MODIFY | Equipment | Gated off the equipment list. One block per item, not one per site. · DC fuse holders, terminations, feeder terminations |
| BESS | 7.13 (one block for whole site) | MODIFY | Equipment | Gated off the equipment list. One block per item, not one per site. · Terminals and disconnects |
| Image labeled with equipment type and ID number | 7.13.8 | HAVE | Image |  |
| Two temperature spots marked | — | NEW | Image |  |
| Hottest point identified and annotated | — | NEW | Image |  |
| Close-up image with termination filling most of the frame | — | NEW | Image |  |
| Full panel photographed showing face of every breaker | — | NEW | Panel |  |
| Temperature spot on each breaker molded case body | — | NEW | Breaker |  |
| Line and load sides photographed separately | — | NEW | Equipment |  |
| Image free of glare or artifacts | — | NEW | Image |  |
| Absolute temperature | — | NEW | Reading | De-energize and investigate |
| AC feeder phase-to-phase delta | 7.13.6 (free entry) | MODIFY | Reading | HARD FAIL: H12 logged 9 deg C and scored it against 10. The AC limit is 5. · Must not exceed 5 deg C |
| DC circuit delta between terminations | — | NEW | Reading | Must not exceed 5 deg C |
| Delta > 10 deg C between similar phases | — | NEW | Reading | De-energize, correct, re-verify with clean image |
| Thermal Anomaly Identified | 7.13.4 (holds 'Pass') | MODIFY | Equipment | Pass is not an answer. Yes must force a punch item. |
| FLIR Thermal Studio report or labeled PDF | 8.4 (blank on Tasman) | MODIFY | Site | Make required before the report will generate. |
| Test Performer + Witness | 7.14.5 blank | MODIFY | Test |  |

### 2.1.2 MLPE Mapping

| Prologis field / check | Scoop source | Action | Repeats per | Note |
|---|---|---|---|---|
| Required whenever MLPE present | — | GATE | Site | This is the substitute evidence for the waived I-V curve. Entirely absent today. · Design Basis Q5 |
| Mapping performed via SolarEdge online mapping tool | — | NEW | Site |  |
| Optimizers installed (count from as-built) | — | NEW | Inverter |  |
| Optimizers paired and reporting (count) | — | NEW | Inverter |  |
| All MLPE paired | — | NEW | Inverter | Acceptance criterion. · paired = installed |
| Communication errors | — | NEW | Inverter | Acceptance criterion. · Must be 0 |
| Mapping matches most up to date as-built layout | — | NEW | Site |  |
| SolarEdge portal mapping screenshot | — | NEW | Site |  |
| Test Performer + Witness | — | NEW | Test |  |

### 2.1.3 AC Voltage Test

| Prologis field / check | Scoop source | Action | Repeats per | Note |
|---|---|---|---|---|
| Company Performing Test / Technician Name | 7.1.3 | MODIFY | Test | 2 fields |
| Meter Manufacturer / Model / Cal Date / Cal Due | — | NEW | Test | 4 fields |
| All conductors correctly labeled and identified | — | NEW | Test |  |
| All conductors landed and insulation resistance tested | 5.3 (blank on Tasman) | MODIFY | Test |  |
| Phase to phase values within 5% of each other | — | NEW | Equipment | Derive from the readings. |
| 1. Line and load side of the main disconnect | — | NEW | Disconnect |  |
| 2. Line and load side of each PV distribution panel breaker | — | NEW | Breaker |  |
| 3. Line and load side of each inverter breaker | — | NEW | Breaker |  |
| 4. Line side of inverter AC disconnect prior to closing | — | NEW | Inverter |  |
| Equipment ID | 7.9.1 (meter only) | MODIFY | Equipment | One reading set at the production meter today. Needs one per sequence point. |
| A-B / A-C / B-C | 7.9.6-7.9.8 | HAVE | Equipment | H12: 492/494/493. Good data, wrong location. · V |
| A-N / B-N / C-N | — | NEW | Equipment | V |
| A-G / B-G / C-G | 7.9.3-7.9.5 | HAVE | Equipment | H12: 283/284/282. · V |
| Inverter covers replaced | — | NEW | Inverter |  |
| Cover screws torqued to manufacturer value, hand tools only | — | NEW | Inverter | Rev 1.00 is explicit: powered tools crack housings and damage gaskets. · Powered tools prohibited |
| Test Performer + Witness | — | NEW | Test |  |

### 3.1.1 DAS Commissioning

| Prologis field / check | Scoop source | Action | Repeats per | Note |
|---|---|---|---|---|
| EPC/Installer On-Site Field Techs | 7.5 block | HAVE | Site |  |
| On-Site Date(s) | — | NEW | Site |  |
| Project Capacity (kW DC) | 4.1 (hot form) | HAVE | Site | kW DC |
| AlsoEnergy Remote Engineer(s) | — | NEW | Site |  |
| Site named correctly and consistently per PLD standards across all platforms | — | NEW | Site | Format: Solar Project ID - Site Name, e.g. SLCVA203 - Lathrop 3 |
| Solar Project ID recorded | — | NEW | Site | Also fixes the closeout file naming convention. |
| Site names on DAS equipment labels are correct | 7.5.4 | HAVE | Site |  |
| Equipment address labels match the actual project site location | 7.5.4 | HAVE | Site |  |
| Enclosure is securely mounted | 7.5.6 | HAVE | Site |  |
| All penetrations are located on the bottom of enclosures | — | NEW | Site |  |
| Rain-tight enclosure connectors used for all penetrations | 7.5.10 | HAVE | Site |  |
| Penetrations on the bottom more than 3/4 inch from enclosure edges | — | NEW | Site | AlsoEnergy voids warranty otherwise. |
| All enclosures are clean and free of debris | 7.5.8 | HAVE | Site |  |
| POA irradiance value is greater than GHI value | — | NEW | Site | Gated: only if a GHI sensor is on the design. |
| All weather sensors are displayed in the monitoring portal | 7.10.11 | HAVE | Site |  |
| Module temperature sensor value is greater than the ambient temperature | — | NEW | Site | Gated on ambient sensor present. |
| Monitoring equipment secured from unauthorized access or vandalism | 7.5.13 | HAVE | Site |  |
| Power LEDs visible after supplying AC power to monitoring enclosures | 7.6.4 | HAVE | Site |  |
| All devices receiving proper voltage (typically 24V) | 7.6.2 | MODIFY | Site | BOTH reports recorded 480V. The AlsoEnergy design shows 100-277VAC in, 24VDC to the devices. |
| Cellular modem antenna installed correctly: small lead to GPS, two larger leads to cellular | — | NEW | Site |  |
| Healthy LED indicators are visible | 7.6.6 | HAVE | Site |  |
| Cellular modem provides IPs via DHCP | — | NEW | Site |  |
| Inverter make and model recorded | 7.1.4 | HAVE | Site |  |
| Communication type recorded as Modbus/RTU or Modbus/TCP | 7.7.3 (RS485) | MODIFY | Site | Rev 1.00 wants the protocol, not the physical layer. |
| Inverter communication wiring is shielded twisted pair | 7.7.5 | HAVE | Site |  |
| Confirm that inverters report to AlsoEnergy portal | 7.7.10 | HAVE | Site |  |
| RS-485 shield is landed only in DAS box | — | NEW | Site |  |
| Terminating resistor properly installed (if required) | 7.7.7 | HAVE | Site |  |
| Inverters communicating properly within monitoring platform | 7.11.2 | HAVE | Site |  |
| Confirm GHI, POA, and BPOA orientation | — | NEW | Site | Gated on which sensors are on the design. |
| GHI azimuth and tilt values recorded | — | NEW | Site | Numeric entry, not a checkbox. |
| POA azimuth and tilt values recorded | — | NEW | Site | Numeric entry, not a checkbox. |
| BPOA azimuth and tilt values recorded | — | NEW | Site | Gated. |
| GHI, POA, Dust, BPOA sensors installed correctly and oriented per design | 7.10.3 | MODIFY | Site | H12 and Tasman both passed GHI. The Hayward design has no GHI sensor. |
| BPOA mounted on the backside of the array centered beneath the module | — | NEW | Site | Gated. |
| Pyranometer is not shaded or reflecting light at any time of day | — | NEW | Site |  |
| Manufacturer pyranometer cables have not been extended or shortened | — | NEW | Site | Analog sensor cables are calibrated to length. |
| Wind sensor mounted at least 3 ft above any surface | — | NEW | Site | Gated. No wind sensor on the Hayward design. |
| Ambient temp sensor shaded with adequate airflow | 7.10.5 | MODIFY | Site | Gated. No ambient sensor on the Hayward design. |
| Cell temperature sensor mounted on center cell of center module | 7.10.6 | MODIFY | Site |  |
| Weather Station ON LED illuminated (if applicable) | — | NEW | Site |  |
| All AlsoEnergy-integrated weather sensors are connected | 7.10.10 | HAVE | Site |  |
| Rainfall sensor installed for systems greater than 5 MW DC | — | NEW | Site | Auto-N/A below 5 MW. |
| Soiling sensor installed for heavy soiling geographies | — | NEW | Site |  |
| POA pyranometer ISO 9060 class recorded | — | NEW | Site | <800 kW DC: first class or secondary standard. Hayward has a Hukseflux SR100-D1, ISO 9060 spectrally flat Class B. Document the equivalence, the form uses pre-2018 wording. |
| Minimum 1 module temperature sensor on site (< 5 MW DC) | — | NEW | Site |  |
| Valid data transmission from all devices verified by DAS provider | 7.11.1 | HAVE | Site |  |
| Energy registers match meter power polarity for each meter | — | NEW | Site |  |
| Third-party or customer-supplied hardware confirmed Modbus-configured with the OEM | — | NEW | Site |  |
| Monitoring portal and comms established for 3rd party OEM products | — | NEW | Site | Panel washing, bird mitigation, cameras, etc. |
| All 3rd party commissioning recommended steps completed | — | NEW | Site |  |
| Installer print / signature / date | 7.11.22 name only | MODIFY | Site |  |
| DAS Provider print / signature / date | — | NEW | Site | Second signature line. Absent entirely. · AlsoEnergy |

### 3.1.2 Production Meter

| Prologis field / check | Scoop source | Action | Repeats per | Note |
|---|---|---|---|---|
| Company Performing Test | — | NEW | Meter |  |
| Start Time / End Time | — | NEW | Meter | 2 fields |
| Date of Test | 7.9.2 | HAVE | Meter |  |
| Meter Manufacturer | 7.8.4 (holds enclosure P/N) | MODIFY | Meter | Pull from the equipment list. H9 production meter is an Elkor Mark II W2-E4-5A-DL. |
| Meter Model | 7.8.4 | MODIFY | Meter |  |
| Meter Serial Number | 7.8.3 (holds gateway serial) | MODIFY | Meter | On Tasman one serial appears in four different fields. |
| CT Manufacturer | — | NEW | Meter |  |
| CT Model | — | NEW | Meter |  |
| CT Catalog Number | — | NEW | Meter |  |
| CT Ratio | 7.8.5 | HAVE | Meter | H12 recorded 300:5. Tasman left it blank while passing the ratio check. |
| Voltage taps and CT phases correctly aligned and color-coded | — | NEW | Meter |  |
| VT wiring configuration matches the plan set (wye, wye grounded, etc.) | — | NEW | Meter |  |
| Electrician verifies programmed CT/PT ratios match installed hardware | 7.8.6 | HAVE | Meter |  |
| CTs installed facing the same direction (photo required) | 7.8.8 | MODIFY | Meter | Photo is required by Rev 1.00. Enforce the attachment. |
| CTs centered and mounted at right angles to conductors | 7.8.9 partial | MODIFY | Meter | Scoop asks centered, not right angles. |
| CT shorting pins disengaged after installation | 7.8.10 | HAVE | Meter |  |
| Meter type classified correctly on the platform as a production meter | — | NEW | Meter |  |
| Phase A / B / C Power | 7.9.11-13 | HAVE | Meter | kW |
| Phase A / B / C Polarity | 7.9.14 aggregate | MODIFY | Meter | Rev 1.00 wants polarity per phase. · + / - |
| Phase A / B / C Compliance Y/N | — | NEW | Meter |  |
| A-Ground / B-Ground / C-Ground | 7.9.3-7.9.5 | HAVE | Meter | V |
| A-B / B-C / C-A | 7.9.6-7.9.8 | HAVE | Meter | V |
| Readings correspond to correct phase alignment and color-coding | — | NEW | Meter |  |
| Data communications visible in platform and match onsite instrument readings | 7.8.12 partial | MODIFY | Meter |  |
| Test Performer + Witness | — | NEW | Meter |  |
| Power is positive on A, B, C when producing AND matches the sum of the inverters | — | NEW | Meter | The cross-check Rev 1.00 asks for and Scoop does not do. |

### 3.1.3 Consumption Meter

| Prologis field / check | Scoop source | Action | Repeats per | Note |
|---|---|---|---|---|
| Applies if a consumption meter is on the design | 7.6 pattern | GATE | Site | Hayward 9 has an Elkor W2-M1-RC-DL consumption meter. Form is absent from Scoop entirely. · Design Basis Q6 |
| Company Performing Test | — | NEW | Meter |  |
| Start Time / End Time | — | NEW | Meter | 2 fields |
| Date of Test | 7.9.2 | NEW | Meter |  |
| Meter Manufacturer | 7.8.4 (holds enclosure P/N) | NEW | Meter | Pull from the equipment list. H9 production meter is an Elkor Mark II W2-E4-5A-DL. |
| Meter Model | 7.8.4 | NEW | Meter |  |
| Meter Serial Number | 7.8.3 (holds gateway serial) | NEW | Meter | On Tasman one serial appears in four different fields. |
| CT Manufacturer | — | NEW | Meter |  |
| CT Model | — | NEW | Meter |  |
| CT Catalog Number | — | NEW | Meter |  |
| CT Ratio | 7.8.5 | NEW | Meter | H12 recorded 300:5. Tasman left it blank while passing the ratio check. |
| Voltage taps and CT phases correctly aligned and color-coded | — | NEW | Meter |  |
| VT wiring configuration matches the plan set (wye, wye grounded, etc.) | — | NEW | Meter |  |
| Electrician verifies programmed CT/PT ratios match installed hardware | 7.8.6 | NEW | Meter |  |
| CTs installed facing the same direction (photo required) | 7.8.8 | NEW | Meter | Photo is required by Rev 1.00. Enforce the attachment. |
| CTs centered and mounted at right angles to conductors | 7.8.9 partial | NEW | Meter | Scoop asks centered, not right angles. |
| CT shorting pins disengaged after installation | 7.8.10 | NEW | Meter |  |
| Meter type classified correctly on the platform as a consumption meter | — | NEW | Meter |  |
| Phase A / B / C Power | 7.9.11-13 | NEW | Meter | kW |
| Phase A / B / C Polarity | 7.9.14 aggregate | NEW | Meter | Rev 1.00 wants polarity per phase. · + / - |
| Phase A / B / C Compliance Y/N | — | NEW | Meter |  |
| A-Ground / B-Ground / C-Ground | 7.9.3-7.9.5 | NEW | Meter | V |
| A-B / B-C / C-A | 7.9.6-7.9.8 | NEW | Meter | V |
| Readings correspond to correct phase alignment and color-coding | — | NEW | Meter |  |
| Data communications visible in platform and match onsite instrument readings | 7.8.12 partial | NEW | Meter |  |
| Test Performer + Witness | — | NEW | Meter |  |
| Power is positive on each phase when consuming | — | NEW | Meter |  |
| Consumption meter power graph does NOT correlate with the PV production meter | — | NEW | Meter | Unique to this form. Nothing else replicates it. |
| Screenshot provided on AM handover checklist | — | NEW | Meter |  |

### 3.1.4 Grid Meter

| Prologis field / check | Scoop source | Action | Repeats per | Note |
|---|---|---|---|---|
| Applies if a grid meter is on the design | 7.6 pattern | GATE | Site | Hayward 9 drawings (WT101) show production + consumption only. Grid meter = N/A. · Design Basis Q6 |
| Company Performing Test | — | NEW | Meter |  |
| Start Time / End Time | — | NEW | Meter | 2 fields |
| Date of Test | 7.9.2 | NEW | Meter |  |
| Meter Manufacturer | 7.8.4 (holds enclosure P/N) | NEW | Meter | Pull from the equipment list. H9 production meter is an Elkor Mark II W2-E4-5A-DL. |
| Meter Model | 7.8.4 | NEW | Meter |  |
| Meter Serial Number | 7.8.3 (holds gateway serial) | NEW | Meter | On Tasman one serial appears in four different fields. |
| CT Manufacturer | — | NEW | Meter |  |
| CT Model | — | NEW | Meter |  |
| CT Catalog Number | — | NEW | Meter |  |
| CT Ratio | 7.8.5 | NEW | Meter | H12 recorded 300:5. Tasman left it blank while passing the ratio check. |
| Voltage taps and CT phases correctly aligned and color-coded | — | NEW | Meter |  |
| VT wiring configuration matches the plan set (wye, wye grounded, etc.) | — | NEW | Meter |  |
| Electrician verifies programmed CT/PT ratios match installed hardware | 7.8.6 | NEW | Meter |  |
| CTs installed facing the same direction (photo required) | 7.8.8 | NEW | Meter | Photo is required by Rev 1.00. Enforce the attachment. |
| CTs centered and mounted at right angles to conductors | 7.8.9 partial | NEW | Meter | Scoop asks centered, not right angles. |
| CT shorting pins disengaged after installation | 7.8.10 | NEW | Meter |  |
| Meter type classified correctly on the platform as a grid meter | — | NEW | Meter |  |
| Phase A / B / C Power | 7.9.11-13 | NEW | Meter | kW |
| Phase A / B / C Polarity | 7.9.14 aggregate | NEW | Meter | Rev 1.00 wants polarity per phase. · + / - |
| Phase A / B / C Compliance Y/N | — | NEW | Meter |  |
| A-Ground / B-Ground / C-Ground | 7.9.3-7.9.5 | NEW | Meter | V |
| A-B / B-C / C-A | 7.9.6-7.9.8 | NEW | Meter | V |
| Readings correspond to correct phase alignment and color-coding | — | NEW | Meter |  |
| Data communications visible in platform and match onsite instrument readings | 7.8.12 partial | NEW | Meter |  |
| Test Performer + Witness | — | NEW | Meter |  |
| Positive on each phase when importing at midnight, negative when exporting during production | — | NEW | Meter |  |
| Screenshot provided on AM handover | — | NEW | Meter |  |
| Ambient Temp | — | NEW | Meter |  |

### 4.0 Performance Acceptance Test

| Prologis field / check | Scoop source | Action | Repeats per | Note |
|---|---|---|---|---|
| All inverters, strings, modules, MLPE, and monitoring fully operational and free of active faults | 7.15.5 partial | MODIFY | Site | PAT entry gate. Their words. |
| System capable of operating at full designed capacity | — | NEW | Site |  |
| Any deficiency reducing available capacity corrected prior to initiating testing | — | NEW | Site | A bad optimizer counts. This is why Bayside 16 legitimately could not start. |
| Non-production-impacting communication alarms present | — | NEW | Site | Useful lever: a monitoring access issue is not a PAT blocker. · Does NOT preclude PAT |
| Owner's Rep approval of Hot Commissioning | — | NEW | Site |  |
| Owner's Rep approval of DAS Commissioning | — | NEW | Site |  |
| Test window | — | NEW | Site | 7 consecutive days |
| Daily peak irradiance | — | NEW | Day | Must peak at 600 W/m2 |
| Day skipped below irradiance threshold | — | NEW | Day | Skipped days are a request we make, not a delay we absorb. · Requires owner approval |
| Weather-adjusted expected energy from DAS platform using site-measured weather | — | NEW | Day | This is why the DAS gaps sit on the PAT critical path. · kWh |
| Actual measured production | — | NEW | Day | kWh |
| Performance ratio | — | NEW | Site | >= 95% to pass |
| Test data uploaded to Execution Closeout Tracker | — | NEW | Site |  |
