---
name: "scoop-api-ops"
description: "Working MBL's Scoop MAE (apps.scoopmae.com) through its API: auth, endpoints that exist, repeating-block and gating rules, report templates, new-job setup, and triage for 'the crew cannot see it.' Use for any Scoop form, field, workflow, or report change."
---

# Scoop MAE, API operations

MBL Energy runs commissioning on Scoop MAE. Front end `apps.scoopmae.com`, API
`https://api.scoopmae.com/api/`. Everything here was learned by doing, mostly by getting it wrong
first.

## Standing rules from Jason

1. Never delete anything in Scoop. Rename, deactivate, or hide behind an always-false rule. Not
   fields, not sections, not scoops, not stages.
2. Never print the bearer token into chat, a file, or a document.
3. Nothing gets uploaded or published anywhere until Jason reviews it.
4. Build notes stay between Jason and Claude. They never go in admin notes or any user-visible field.
5. Field-facing wording sounds like MBL, not like software.

## Auth

On an `apps.scoopmae.com` tab, via the browser javascript tool (built-in browser or Chrome):

```js
const t = localStorage.getItem('scoop-access-token');   // bare string, not JSON
window.__H = {'Authorization':'Bearer '+t, 'Content-Type':'application/json'};
```

Stash on `window` once per tab, reset after navigation.

Bridge limits: about 45 s per call, about 1000 characters of output. Loop in chunks, keep state on
`window`, print summaries not raw records. Long query strings sometimes trip the client filter
("BLOCKED: Cookie/query string data") - build the URL from variables and print less. If a tab
freezes, open a fresh one; the in-flight request usually completed.

## Endpoints that exist

```
GET  /users?per_page=200
GET  /scoops?page=N&per_page=50          omits archive-stage scoops, see below
GET  /scoops?page=1&per_page=100&app_id=<appId>   fast; without app_id it can hang
GET  /scoops/index_removed?page=1        deleted scoops
GET  /scoops/{id}                        works even for archived
GET  /scoops/{id}/scoop_sections
GET  /scoop_sections/{id}                includes scoop_fields with values AND choices (ids + names)
PUT  /scoop_fields/{id}                  {"scoop_field":{"value": ...}}  app-local and client-site fields
PUT  /project_fields/{id}                {"project_field":{"value": ...}}  project-linked fields
GET  /projects?page=N                    25 per page, loop pages
GET  /projects/{id}
GET  /groups?page=N&per_page=100         client sites; pages repeat, dedupe by id
GET  /groups/{id}
POST /scoops/{id}/scoop_sections         {"scoop_section":{"form_section_id":"..."}}
GET  /apps/{id}
GET  /apps/{id}/form_sections
GET  /apps/{id}/form_fields              the ONLY field list route
GET  /apps/{id}/conditional_display_rules
POST /apps/{draftId}/form_fields
PUT  /form_fields/{draftFieldId}
PUT  /form_sections/{draftSectionId}     send the whole attribute set, not just the change
POST /apps/{draftId}/conditional_display_rules
POST /apps/{draftId}/workflow_stages     notification_scheme_id is REQUIRED, copy an existing one
POST /workflow_stages/{fromId}/workflow_transitions
PUT  /apps/{publishedId}/publish_draft   no body, takes about 2 minutes
GET  /report_templates                   all templates, all apps
GET  /report_templates/{id}
PUT  /report_templates/{id}
```

404s, do not keep guessing: `/form_sections/{id}/form_fields`, `/apps/{id}/report_templates`,
`/scoops/{id}/media`, transition-action creation routes. Learn an unknown route by doing the
action in the UI with `read_network_requests` running.

Draft IDs change on every publish. Always re-fetch before writing to a draft.

## Writing values: pick the right route

A scoop field is one of three kinds, and the write route depends on which:

- `group_global_field_id` set: client-site global field. `PUT /scoop_fields/{id}` works and the
  value lands on the client site.
- Neither set: app-local. `PUT /scoop_fields/{id}` works.
- `project_template_field_id` + `project_field_id` set: project-linked. `PUT /scoop_fields/{id}`
  can return 200 and SILENTLY DISCARD the value (updated_at does not move, value stays null). Write
  with `PUT /project_fields/{project_field_id}` instead. Hit this on the whole 6.1 PCC Data Sheet.

A 200 proves nothing. Always re-GET the field after writing.

## New job setup: client site, project, Cold CX prefilled from drawings

Use when Jason asks to create commissioning for a job that is not in Scoop yet.

1. **Read the drawings first.** SharePoint Field > Jobs In Progress > <job> > 1_Drawings (title
   sheet, E101 stringing table, E200 SLD, E502 equipment) and 9_Field summary and BOMs. The plan
   set wins over intake sheets, which go stale. PDFs over ~40 MB fail text extraction through the
   connector; fall back to the prior rev and say so.
2. **Check it doesn't already exist.** Search `/groups` and `/projects` for the site name.
3. **Client site under the proper client.** Client Sites > New. Place it under
   3. EPC > <client>: JCI jobs under "Johnson Controls, Inc.", Prologis under "Prologis Energy,
   LLC". Confirm only that one box is checked before Save & Exit.
4. **Project.** `#/home/projects/new`: link the site, EPC / Turnkey / Specialty Contractor, fill
   Customer Information (owner, company, contact, address, utility, AHJ), Project Intake (size,
   scope, specs), Project Administration (Project Type Full EPC, job number). Text fields accept a
   native value setter plus input/change events; dropdowns need real clicks.
5. **Scoop.** `#/home/scoops/new`: Cold Commissioning app, same site, same project, Save &
   Complete. Do not invite crew unless Jason names them.
6. **Prefill** job-level and design-basis fields only: section 1 site info (geolocation takes
   `{details:{},address,lat,lng}`), section 4 system specs, 6.1 PCC sheet (via project_fields),
   inverter count/model. Leave every field test for the crew.
7. **Prologis gate.** New Cold CX scoops come with "Prologis Project (PLD spec applies)" defaulted to
   Yes. On non-Prologis jobs set it to No (`c2b8e151-f8c4-4b50-8be3-4119ca2ef684`).
8. **String table.** Inverter Test Sheet (6.6) and MPPT VOC blocks (6.11) are project-linked, so
   duplicate blocks likely share one value (unverified; test on Bishop Ranch_Test). Put the design
   string table (modules in series x strings per MPPT, expected Voc) in 6.6.5 Overall Notes rather
   than per-inverter blocks.
9. **Verify** by re-reading every written field, then report what is filled, what conflicts
   between documents, and what the template pre-answers (some Megger/IR/UL items default to a
   passing answer and must be confirmed in the field).

## The rules that actually matter

**Repeating blocks: project-linked vs app-local.** A field created with
`create_external_source_fields` carries a `project_template_field_id` and resolves its value at the
PROJECT level, so every duplicate block shows one shared value. A field created directly with
`POST /apps/{draftId}/form_fields` and a `form_section_id` (no `project_template_field_id`) stores
per block. Repeating-block fields must be app-local. Non-repeating fields should stay
project-linked so they roll up.

**Nesting (`parent_id`) decides nothing useful.** Changing it on a live app breaks the add-block
button on every in-flight scoop, because a scoop keeps the section tree it was created with while
the button takes its parent requirement from the current app. Do not restructure sections on a live
app. Change fields.

**Hidden fields keep their values** and still return them through the API. Writes to a hidden field
return 403. A 403 on an ordinary text field almost always means its gate is unanswered, not that
something is broken.

**Choice IDs.** `GET /scoop_sections/{id}` returns each field's `choices` with ids and names, so
read them there. A data source choice that is not on any scoop field may still need to be learned
by picking the option in the UI and reading the stored value back.

**Archive-stage scoops are invisible to `GET /scoops`.** Not on any page, not via `?project_id=`,
and `?workflow_stage_id=` is ignored. Any sweep built on the list endpoint silently skips every
closed package. Reach them by direct ID or through the UI. Say so rather than reporting a sweep as
complete.

## PDF report templates

Separate from the app. No publish needed, changes apply on save.

`settings.form_field_ids` is a flat array of app field ids and is the whole story for what prints.
There is no section list; a section appears when one of its fields is on the array.
`include_form_sections: "some"` just means it is a subset.

To add fields: GET the template, concat the ids, PUT back the full
`{report_template:{name, template_type, app_id, settings}}`. Then re-GET and verify three things:
the count, that no superseded/hidden field ids crept in, and that there are no duplicate ids.

Build the id list from `GET /apps/{id}/form_fields`, filtering out anything whose
`conditional_display_rule.name` matches superseded or retired.

**The wizard defaults to "One-Click Report: use standard report settings", not the saved template.**
A correct template does not reach the crew unless they pick it from the dropdown or a workflow
action generates it. Check this before declaring a report fixed.

`email_pdf:false, save_pdf:true` means generating a test report is non-destructive: it writes a PDF
into the scoop and mails nobody.

## Triage: "the crew cannot see it"

Run in this order before touching anything.

1. **Check the gate on their specific scoop.** Read the Prologis Commissioning Requirements section
   and look at `Prologis Project (PLD spec applies)`. Empty array means every gated field is hidden
   and the section shows one lonely question. This is the cause most of the time.
2. **Compare against a scoop where it works.** If the same person sees it on one site and not
   another, it is data, not the app or the iPad.
3. **Check rule scoping.** `role_ids` and `workflow_stage_ids` on the CDR. Usually empty, which
   rules out permissions in one call.
4. **Only then look at structure.**

Do not blanket-answer gates to unblock a migration. Some sites are not Prologis jobs, and stray
block values on them are template carry-over, not real data. A person has to say which sites are
Prologis.

## Verification discipline

The repeated failure mode on this account has been confirming structure and calling it fixed.
Structure is not behavior.

- Prove a repeating block by writing two different values into two blocks and reading them back.
- Prove a gate by writing to a gated field before and after answering it (403 then 200).
- Prove a button works by clicking it in the browser and counting blocks.
- After a bulk change, re-read from the API rather than trusting the write log. A 200 on a write
  is not proof: project-linked fields return 200 on the wrong route and store nothing.
- When something is unverified, say which part is unverified and name the cheapest test. Do not let
  a verified half carry an unverified half.

## Key IDs

```
Cold Commissioning app       cbed3d36-e41c-4b08-b724-aff93f78f98b
Hot Commissioning app        441fc525-dd49-411d-a8e8-9f812d4e61b5
Interconnection Tie-In app   053cc245-408d-4cbf-849d-3d1441f4e64a
Cold report template         0eaaf200-8cfa-4fca-9f9e-de81d24d6727
Hot report template          616f1a48-6ddb-4f6e-8226-d49df50ce0f7
EPC project template         bd245d32-f509-4e5e-9dd1-cec8d9625f79
Prolologis gate field        eeab96f2-60a9-4f4d-a4e2-da027a5ed395
Prolologis gate Yes / No     b5972796-7c04-467f-8ec9-777872ebd596 / c2b8e151-f8c4-4b50-8be3-4119ca2ef684
RMA gate field               d12b516b-475b-4272-b28c-9e53234d0ced
RMA Yes / No                 fd652867-4be4-4417-a562-6d1f0194c00e / a8aa3d1b-aa59-4853-a79f-9e565a38daa8
Johnson Controls, Inc. group 4d7eb937-403e-4d15-8358-6e7c7a257720 (under 3. EPC)
Bishop Ranch_Test scoops     cold e0799f76-f266-418b-9d7d-dbff203a9a17, hot ac5b8b37-8640-4858-8ddd-73d49d86ccd6
Coalinga WWTP                site 37e68105-774a-41a5-9504-7cf1635c91d3, project e9a7b960-2d35-4cba-8509-7a8214a6d687, cold f54aa9e4-aab9-4a56-ab8a-0ac7c25e5450
Nathalie ba4f4347-c8d6-473d-9014-78f2e236da4d   Derek da9f114a-30bf-4d57-9c40-61ed756e5509
Chase    155a49da-6833-4df0-a32d-6f1af614126f   Jereme 062f025c-d89d-4b79-b7c8-3a65c3060310
```

Bishop Ranch_Test is the safe place to test. Never test on a live job.

## Where the written record lives

The Cold CX / Hot CX project holds the long-form history: `claude/scoop-repeating-blocks-and-nesting.md`,
`claude/scoop-report-templates.md`, `claude/scoop-api.md`, `claude/scoop-publish-and-gating.md`.
Read the relevant one before changing something in that area, and write findings back when done.