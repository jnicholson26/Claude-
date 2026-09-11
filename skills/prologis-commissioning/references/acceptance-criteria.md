# Acceptance criteria in Rev 1.00

Derive pass/fail from these rather than copying the technician's answer. Scoop has been observed scoring against the wrong threshold in several places, and a copied wrong answer becomes MBL's wrong answer on a Prologis form.

## Insulation resistance — NETA 7.3.3

| Nominal equipment rating (V) | Minimum test voltage (Vdc) | Minimum insulation resistance |
|---|---|---|
| 250 | 500 | 25 MΩ |
| 600 | 1000 | 100 MΩ |
| 1000 | 1000 | 100 MΩ |
| 2500 | 1000 | 500 MΩ |
| 5000 | 2500 | 1000 MΩ |
| 8000 | 2500 | 2000 MΩ |
| 15000 | 2500 | 5000 MΩ |
| 25000 | 5000 | 20000 MΩ |
| 34500 and above | 15000 | 100000 MΩ |

Test duration is 60 seconds. Anything below the minimum for its test voltage is an anomaly.

**Unit ambiguity is a live problem.** Scoop's IR fields are labelled "MΩ/GΩ" with no selector, and readings have come through as bare numbers like `2.2`. Read as GΩ that is 2200 MΩ and passes a 600 V class circuit comfortably; read as MΩ it is a hard fail. Never assume — resolve it with the field tech, and specify a unit selector in any build.

## Ground continuity

- No single bonded connection above **0.5 Ω**
- Investigate any point-to-point value exceeding **1.0 Ω**
- Bolted connection resistance must not vary by more than **50%** across comparable connections
- Distance point-to-point in feet is a required field

Do not confuse this with the ground **electrode** criterion of 25 Ω. Scoop has been observed scoring continuity readings against 25 Ω, which passes almost anything.

## Thermography

Pre-test conditions, both from Rev 1.00 §2.1.1:

- Irradiance at least **600 W/m²**, *or* measured equipment output at **50% load or greater**
- System operating approximately **30 minutes** so components reach temperature
- Covers, arc flash guards and dead fronts removed immediately prior to imaging

A scan below these conditions does not prove anything, because there is not enough current flowing to heat a bad connection. Treat a low-irradiance scan as a retest, not a marginal pass.

Camera settings: Celsius, reflected temperature 20 °C, emissivity 0.95, measurement distance 1 metre.

Evaluation criteria:

- Absolute temperature at or above **60 °C** — de-energize and investigate
- AC feeder phase-to-phase delta must not exceed **5 °C**
- DC circuit delta between terminations must not exceed **5 °C**
- Any connection with a delta above **10 °C** between similar phases comes offline until corrected and verified with a clean image

The 5 °C limit is the one most often missed. A 9 °C delta scored against a criterion of 10 passes on MBL's form and fails on Prologis's.

## Torque

- Test **all** electrical connections
- Test **3%** of each type of mechanical connection
- Impact drivers are prohibited by PLD developer specification
- Mechanical lugs: torque the Allen set screw first, then the mounting bolt, and record both
- Both compression and mechanical lugs need bolt stack, hardware grade and torque values documented
- Parallel sets are tested and recorded individually
- Passing connections get a paint pen or tamper-proof strike mark
- Racking bolts to manufacturer specification, or NETA-ATS Tables 100.12.1 through 100.12.4
- Bolted terminations get rechecked during hot commissioning via thermography, per NETA ATS 7.1.A.8

Equipment in scope per Rev 1.00 Table 9: AC disconnects (phase conductors, fuses, grounding), switchgear and panelboards (phase conductors, breakers, fuses, grounding), inverters (phase conductors, grounding, DC strings and feeder), pull boxes (grounding), DC distribution (grounding), racking (mechanical attachments and hardware).

## I-V curve

Required when real-time monitoring of optimizer health is unavailable. MLPE may prohibit the test — confirm method with the EOR and component manufacturers, and keep that confirmation as a document.

- Irradiance stable and at least **600 W/m²** (IEC 62446 §7.2.3)
- Fill factor above **70%**
- Performance factor **95%** acceptable
- **90–95%** pending owner acceptance
- Below **90%** must be addressed and investigated
- Fill factor below 70% is unacceptable

Performance factor is the preferred primary criterion; fill factor is the alternate where the device does not calculate performance factor. Device automated output with tabular data and graphs must be submitted.

## Compression fittings

Number of crimps must meet the OEM required crimp count. Pre-test conditions: conductors not scored from stripping, antioxidant applied to aluminium before crimping, no heat shrink applied between connectors, crimp tool meeting minimum specification (12 ton, not dieless on certain wire sizes), tool calibration within one year.

## PAT entry and pass

Entry conditions, quoted because the wording matters in scheduling disputes:

> "Performance Acceptance Testing (PAT) shall not commence unless all inverters, strings, modules, MLPE devices (if applicable), and monitoring systems are fully operational and free of active faults. The system must be capable of operating at its full designed capacity at the time of testing. Non-production-impacting communication alarms shall not preclude PAT; however, any deficiency that reduces available system capacity shall be corrected prior to initiating testing."

Practical consequences: a failed optimizer reduces capacity and legitimately blocks PAT entry. A monitoring access problem that does not impact production does **not** block PAT.

Test conditions:

- Seven consecutive days
- Irradiance must peak at **600 W/m²** on a counted day
- Cloudy days below the threshold may be skipped **with owner approval** — skipped days are a request to make, not a delay to absorb
- Expected energy is the weather-adjusted value calculated by the DAS platform using actual site-measured weather data
- Pass is **95% minimum** of weather-adjusted expected energy versus actual

PAT begins only after the Owner's Representative approves both hot commissioning and DAS commissioning. Because expected energy comes from the DAS platform's weather-adjusted calculation, DAS commissioning gaps sit directly on the PAT critical path.

## Weather station sizing rules

- Projects under 800 kW DC: POA pyranometer ISO 9060 first class or secondary standard
- Projects over 800 kW DC: POA pyranometer ISO 9060 secondary standard
- Projects under 5 MW DC: minimum one module temperature sensor
- Projects over 5 MW DC: minimum three module temperature sensors
- Rainfall sensor for systems greater than 5 MW DC, first distributed station
- Soiling sensor in geographies with heavy soiling
