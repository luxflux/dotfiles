# vim: ft=muttrc

# Default inbox.
set spoolfile = "+welltravel.com/INBOX"

# Alternate email addresses.
alternates raffael.schmid@welltravel.com

# Other special folders.
set mbox      = "+welltravel.com/All Mail"
set postponed = "+welltravel.com/Drafts"
set record    = "+welltravel.com/Sent Mail"
set trash     = "+welltravel.com/Bin"

set from     = "raffael.schmid@welltravel.com"
set realname = "Raffael Schmid - Welltravel"
set sendmail = "/usr/local/bin/msmtp -a welltravel"

macro index,pager ,a "<save-message>+welltravel.com/All\ Mail<enter>"  "mark message as Archived"
