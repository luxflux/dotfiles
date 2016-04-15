# vim: ft=muttrc

# Default inbox.
set spoolfile = "+yux.ch/INBOX"

# Alternate email addresses.
alternates raffael@yux.ch mir2@yux.ch

# Other special folders.
set mbox      = "+yux.ch/archive"
set postponed = "+yux.ch/drafts"
set record    = "+yux.ch/Sent"

set from     = "raffael@yux.ch"
set sendmail = "/usr/local/bin/msmtp -a yux"

macro index,pager \Ca "<save-message>+yux.ch/Archive<enter>"  "mark message as Archived"