#!/bin/bash

ghostty-new-tab() {
  local cmd="$*"

  osascript <<EOF
tell application "Ghostty" to activate
tell application "System Events"
    tell process "Ghostty"
        keystroke "t" using command down
        delay 0.15
        keystroke "$cmd"
        keystroke return
    end tell
end tell
EOF
}
