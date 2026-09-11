# Form inventory — Rev 1.00

Twenty-one forms plus PAT. Appendix location in brackets.

## Cold commissioning (§1.1)

| § | Form | Appendix | Purpose |
|---|---|---|---|
| 1.1.1 | Interconnection | 4 | Pre-energization test set on the tie. See `interconnection.md`. |
| 1.1.2 | Compression Fitting Inspection Report | 1, 4 | Crimp count vs OEM requirement, compression value, resistance. Irreversible once shrink is applied. |
| 1.1.3 | AC Feeder Insulation Resistance | 1, 4 | Ten readings per feeder including all four neutral combinations. |
| 1.1.4 | DC String Insulation Resistance | 1 | Per inverter, per string: pos-neg, pos-gnd, neg-gnd. |
| 1.1.5 | DC Feeder (Combined) Insulation Resistance | 1 | Per combiner, per conductor. N/A when combiner count is zero. |
| 1.1.6 | Ground Continuity | 1, 4 | Point-to-point pairs with distance. 0.5 Ω per bonded connection. |
| 1.1.7 | Ground Fault Injection | 1 | NEC 2023 230.95(C). Pickup, trip and no-trip tests per phase. Gated on GFPE appearing on the SLD. |
| 1.1.8.1 | Electrical Torque Verification | 1, 4 | All electrical connections. Equipment ID, conductor ID, criteria, pass per A/B/C/N/G. |
| 1.1.8.2 | Mechanical Torque Verification | 1 | 3% of each mechanical connection type. Racking, pull boxes, DC distribution. |
| 1.1.9 | Visual Inspection Witness Before Concealment | 1, 4 | 22 checks with photo links across trenches, foundations and pads, canopy structures. |
| 1.1.10 | Inverter DC Input Commissioning | 1 | Safety voltage measured vs expected per string, polarity, fuse continuity, comms wire verification. |
| 1.1.11 | I-V Curve Tracing | — | Device automated report. Usually waived where MLPE is present; the waiver needs to be a document. |
| 1.1.12 | Medium Voltage Cable VLF | 1 | Leakage current per phase over time. N/A below 1000 V. |
| 1.1.13 | Transformer Commissioning | — | NETA standard tests. N/A where no transformer. |
| 1.1.14 | Cold Commissioning General Inspection | 1 | ~30 checks: site condition, conductors, modules, equipment, racking, wire management, corrosion, shading, torque marks. |

## Hot commissioning (§2.1)

| § | Form | Appendix | Purpose |
|---|---|---|---|
| 2.1.1 | Handheld Thermography | — | Table 12 equipment scope. Report in FLIR Thermal Studio format or labelled PDF. |
| 2.1.2 | MLPE Mapping | — | SolarEdge online mapping tool. All MLPE paired and reporting, zero comms errors. This is the substitute evidence when the I-V curve is waived. |
| 2.1.3 | AC Voltage Test | 2 | Four-point sequence: main disconnect, PV distribution panel breakers, inverter breakers, inverter AC disconnect line side. |

## DAS and metering (§3.1)

| § | Form | Appendix | Purpose |
|---|---|---|---|
| 3.1.1 | DAS Commissioning Checklist | 3 | ~40 checks. Two signatures: Installer and DAS Provider (AlsoEnergy). |
| 3.1.2 | Production Meter Setting | 3 | Positive on all phases when producing, and matches the sum of the inverters. |
| 3.1.3 | Consumption Meter Setting | 3 | Positive when consuming. Unique check: power graph must NOT correlate with the production meter. |
| 3.1.4 | Grid Meter Setting | 3 | Bi-directional. Positive importing at midnight, negative exporting during production. |

## Performance acceptance

| § | Item | Purpose |
|---|---|---|
| 4.0 | Performance Acceptance Test | Seven consecutive days, 600 W/m² peak, ≥95% of weather-adjusted expected energy. |

## Sign-off blocks

Nearly every cold form and all three meter forms carry a two-line sign-off: **Test Performer** and **Witness**, each with print name, signature and date. Rev 1.00's cold commissioning preamble states the tests "require qualified personnel to witness and verify the correct procedures are being followed," so the witness is not decorative. The DAS checklist instead carries Installer and DAS Provider signatures.

Every form also opens with a **Testing and Measurement Equipment** block: manufacturer, model, calibration date, calibration due date. And a **Company Performing Test** field, which Prologis uses to separate self-performed from subcontracted work at audit.
