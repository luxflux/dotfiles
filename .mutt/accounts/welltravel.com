# vim: ft=muttrc

# Default inbox.
set spoolfile = "+welltravel.com/INBOX"

# Alternate email addresses.
alternates raffael.schmid@welltravel.com

# Other special folders.
set mbox      = "+welltravel.com/INBOX.Archive"
set postponed = "+welltravel.com/INBOX.Drafts"
set record    = "+welltravel.com/INBOX.Sent"

set from     = "raffael.schmid@welltravel.com"
set realname = "Raffael Schmid - Welltravel"
set sendmail = "/usr/local/bin/msmtp -a welltravel"

macro index,pager ,a "<save-message>+welltravel.com/INBOX.Archive<enter>"  "mark message as Archived"
