# FRC USB Connection Kit
A tool for sending and recieving files from an android device, specifically for the purpose of database management at FRC competitions.

### Usage
To use the FRC USB Connection Kit, you need
- The Android Debugging Bridge (adb)
- Bash

To send a file, run `fuck.sh send <file>`. This will send the file to `/sdcard/db/<file>`

To get a file, run `fuck.sh get <file>`, where <file> is a file located in `/sdcard/db/`. This will get the file and copy it to `.`.

### TODO
[\*] Recieve files
[ ] Curses TUI
[ ] Shell-like command wrappers (e.g. fuck.sh ls)
