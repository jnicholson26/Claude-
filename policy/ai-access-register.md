# MBL Energy AI Access Register

The single record of what MBL's AI assistants are permitted to do, who approved it,
and what is still outstanding. Check here before opening a new IT ticket.

Owner: Jason Nicholson. Master copy: S:\Claude (Robert, Jason, Colby, Chase).

## Granted

| Date | Ticket | What was granted | Approved by | Applies to |
|---|---|---|---|---|
| 2026-09-10 | 134009 | Mailbox write and send, delegated, on the Claude app registration | Colby | All agents using the Microsoft 365 connector |
| 2026-09-10 | 135499 | Secured folder S:\Claude, restricted to four named users | Chase | The four named users |

## Outstanding

| Requested | What is needed | Why it matters | Status |
|---|---|---|---|
| 2026-09-10 | SharePoint write, delegated, same app registration | Without it no assistant can file, upload or move a document. Blocks commissioning uploads and the company knowledge library. | Open |
| Not yet raised | A SharePoint library for company templates and approved SOPs | Assistants serving the whole company cannot read a file share. | Not raised |

## How to read this

A grant is made once on the Claude app registration and then covers every assistant that
runs through it. It is not granted per assistant. If a new assistant needs something the
table above already shows as granted, no ticket is required.

## Known limits, so nobody re-litigates them

The Microsoft 365 connector signs in as a person and acts as that person. It cannot send
from a different mailbox, so an assistant cannot have its own company sending address
through this connector. Assistants needing their own address use a separate mail service.

S:\Claude sits on the file server. It is reachable from a workstation and from an
assistant running on that workstation, but not from an assistant running on its own
schedule, and not by anyone outside the four named users. Anything needing automated or
company-wide access belongs in SharePoint instead.
