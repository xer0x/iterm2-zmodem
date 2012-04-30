#!/bin/bash
# Author: Matt Mastracci (matthew@mastracci.com)
# AppleScript from http://stackoverflow.com/questions/4309087/cancel-button-on-osascript-in-a-bash-script
# licensed under cc-wiki with attribution required 
# Remainder of script public domain

#FILE=`osascript -e 'tell application "iTerm" to activate' -e 'tell application "iTerm" to set thefile to choose folder with prompt "Choose a folder to place received files in"' -e "do shell script (\"echo \"&(quoted form of POSIX path of thefile as Unicode text)&\"\")"`
FILE="/Users/"`whoami`"/Downloads"
if [[ $FILE = "" ]]; then
	echo Cancelled.
	# Send ZModem cancel
	echo -e \\x18\\x18\\x18\\x18\\x18
	echo "# Cancelled transfer       "
	/usr/local/bin/growlnotify -a /Applications/iTerm.app -n "iTerm" -m 'Cancelled.' -t "File transfer"
	echo
else
	echo $FILE
	cd "${FILE}"
	/usr/local/bin/growlnotify -a /Applications/iTerm.app -n "iTerm" -m 'Transfer started...' -t "File transfer"
	/usr/local/bin/rz
	/usr/local/bin/growlnotify -a /Applications/iTerm.app -n "iTerm" -m 'Transfer finished.' -t "File transfer"
	echo "# Transfer finished        "
	echo
fi
