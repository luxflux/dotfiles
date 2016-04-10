# vim: ft=muttrc

# Default inbox.
set spoolfile = "+welltravel.com/INBOX"

# Alternate email addresses.
alternates raffael.schmid@welltravel.com

# Other special folders.
set mbox      = "+welltravel.com/Archive"
set postponed = "+welltravel.com/Drafts"
set record    = "+welltravel.com/Sent"

set from     = "raffael.schmid@welltravel.com"
set sendmail = "/usr/local/bin/msmtp -a welltravel"

macro index,pager \Ca "<save-message>+welltravel.com/Archive<enter>"  "mark message as Archived"
