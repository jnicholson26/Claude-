---
name: scoop-api-ops
description: "Working MBL's Scoop MAE (apps.scoopmae.com) through its API: auth, endpoints that exist, repeating-block and gating rules, report templates, and triage for 'the crew cannot see it.' Use for any Scoop form, field, workflow, or report change."
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

On an `apps.scoopmae.com` tab, via the Chrome javascript tool:

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
GET  /scoops/index_removed?page=1        deleted scoops
GET  /scoops/{id}                        works even for archived
GET  /scoops/{id}/scoop_sections
GET  /scoop_sections/{id}                includes scoop_fields with values
PUT  /scoop_fields/{id}                  {"scoop_field":{"value": ...}}
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

**Data source choice IDs are not readable from any endpoint.** The only way to learn one is to pick
the option in the UI and read the stored value back.

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
- After a bulk change, re-read from the API rather than trusting the write log.
- When something is unverified, say which part is unverified and name the cheapest test. Do not let
  a verified half carry an unverified half.

## Key IDs

```
Cold Commissioning app       cbed3d36-e41c-4b08-b724-aff93f78f98b
Hot Commissioning app        441fc525-dd49-411d-a8e8-9f812d4e61b5
Interconnection Tie-In app   053cc245-408d-4cbf-849d-3d1441f4e64a
Cold report template         0eaaf200-8cfa-4fca-9f9e-de81d24d6727
Hot report template          616f1a48-6ddb-4f6e-8226-d49df50ce0f7
Prolologis gate field        eeab96f2-60a9-4f4d-a4e2-da027a5ed395
Prologis gate "Yes" choice   b5972796-7c04-467f-8ec9-777872ebd596
RMA gate field               d12b516b-475b-4272-b28c-9e53234d0ced
RMA Yes / No                 fd652867-4be4-4417-a562-6d1f0194c00e / a8aa3d1b-aa59-4853-a79f-9e565a38daa8
Bishop Ranch_Test scoops     cold e0799f76-f266-418b-9d7d-dbff203a9a17, hot ac5b8b37-8640-4858-8ddd-73d49d86ccd6
Nathalie ba4f4347-c8d6-473d-9014-78f2e236da4d   Derek da9f114a-30bf-4d57-9c40-61ed756e5509
Chase    155a49da-6833-4df0-a32d-6f1af614126f   Jereme 062f025c-d89d-4b79-b7c8-3a65c3060310
```

Bishop Ranch_Test is the safe place to test. Never test on a live job.

## Where the written record lives

The Cold CX / Hot CX project holds the long-form history: `claude/scoop-repeating-blocks-and-nesting.md`,
`claude/scoop-report-templates.md`, `claude/scoop-api.md`, `claude/scoop-publish-and-gating.md`.
Read the relevant one before changing something in that area, and write findings back when done.