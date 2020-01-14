# FRC USB Connection Kit
A tool for sending and recieving files from an android device, specifically for the purpose of database management at FRC competitions.

### Usage
To use the FRC USB Connection Kit, you need
- The Android Debugging Bridge (adb)
- Bash

To send a file to android, run `afuck.sh send <file>`. This will send the file to `/sdcard/db/<file>`

To get a file, run `afuck.sh get <file>`, where <file> is a file located in `/sdcard/db/`. This will get the file and copy it to `.`.

`afuck.sh` can also run in the background and automatically pull a file from an Android device after it's connected. To use this, run `afuck.sh auto <file> &`

### TODO
[\*] Recieve files

[ ] Curses TUI
