#!/usr/bin/env bash

# Print an error message and return code 1
fail() {
	printf "\e[31mERROR!:\e[0m %s\n" "$1"
	exit 1
}

# Print usage and quit
usage() {
	printf "Usage: fuck.sh <send|get|auto> <target>\n"
	exit 0 
}

# Check for a command
check() {
	command -v "$1" &> /dev/null || fail "fuck.sh requires $1. Please install it or add it to your path."
}

###
### Commands
###

# Send a file to /sdcard/db/$FILE
send() {
        printf "Sending $FILE...\n"
        # Make sure /sdcard/db exists. If not, make it
        if ! adb shell "ls /sdcard/db" &> /dev/null; then
                printf "Creating /sdcard/db/\n"
                adb shell "mkdir /sdcard/db" || fail "Failed to make /sdcard/db"
        fi

        adb push "$FILE" "/sdcard/db/$FILE" || fail "Failed to push via ADB"
        printf "Successfully sent $FILE!\n"
}

# Get a file from /sdcard/db/$FILE
get() {
	printf "Getting $FILE...\n"
	# Make sure file exists. If not, error
	if ! adb shell "ls /sdcard/db/$FILE" &> /dev/null; then fail "No file $FILE fonud!"; fi
	
	adb pull "/sdcard/db/$FILE" || fail "Failed to pull via ADB"
	printf "Successfully got $FILE!\n"
}

# Wait for a device to be plugged in and then drop files to it
auto() {
	while :; do
		if [ $(adb devices | wc -l) -gt 2 ]; then
			fuck.sh get $FILE
		fi
		sleep 1
	done	
}

# If no arguments are supplied, print the usage and exit
if [ -z $1 ] || [ -z $2 ]; then usage; fi

###
### Setup
###

# Check for ADB
check adb

# Make sure ADB is running
PROC=$(pgrep adb)
if [ -z $PROC ]; then fail "Please start an ADB server"; fi
printf "Found ADB server at %s\n" $PROC

COMMAND="$1"
FILE="$2"

# Iterate over command
case $1 in
        "send" | "s") send ;;
        "get" | "g")  get ;;
	"auto" | "a") auto ;;
	*) fail "$1 is not a valid command!" ;;
esac
