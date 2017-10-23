# vim: ft=muttrc

# Default inbox.
set spoolfile = "+yux.ch/INBOX"

# Alternate email addresses.
alternates raffael@yux.ch mir2@yux.ch

# Other special folders.
set mbox      = "+yux.ch/Archive"
set postponed = "+yux.ch/Drafts"
set record    = "+yux.ch/Sent"

set from     = "raffael@yux.ch"
set realname = "Raffael Schmid"
set sendmail = "/usr/local/bin/msmtp -a yux"

macro index,pager ,a "<save-message>+yux.ch/Archive<enter>"  "mark message as Archived"
