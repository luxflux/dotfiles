# vim: ft=muttrc

# Default inbox.
set spoolfile = "+hakuna.ch/INBOX"

# Alternate email addresses.
alternates raffael@hakuna.ch

# Other special folders.
set mbox      = "+hakuna.ch/Archive"
set postponed = "+hakuna.ch/Drafts"
set record    = "+hakuna.ch/Sent"

set from     = "raffael@hakuna.ch"
set realname = "Raffael Schmid | hakuna"
set sendmail = "/usr/local/bin/msmtp -a hakuna"

macro index,pager ,a "<save-message>+hakuna.ch/Archive<enter>"  "mark message as Archived"
