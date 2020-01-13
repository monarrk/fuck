#!/usr/bin/env bash

# Print an error message and return code 1
fail() {
	printf "\e[31mERROR!:\e[0m %s\n" "$1"
	exit 1
}

# Print usage and quit
usage() {
	printf "Usage: fuck.sh <file>\n"
	exit 0 
}

# If no arguments are supplied, print the usage and exit
if [ -z $1 ]; then usage; fi

# Make sure ADB is running
PROC=$(pgrep adb)
if [ -z $PROC ]; then fail "Please start an ADB server"; fi
printf "Found ADB at %s\n" $PROC

# Make sure /sdcard/db exists. If not, make it
if ! adb shell "ls /sdcard/db" &> /dev/null; then
	printf "Creating /sdcard/db/\n"
	adb shell "mkdir /sdcard/db" || fail "Failed to make /sdcard/db"
fi

sudo adb push "$1" "/sdcard/db/$1" || fail "Failed to push via ADB"
