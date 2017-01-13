# i3CycleWorkspace
This directory contains a python script that allows cycling through i3 workspaces.

## example
Add the following lines to your i3 config:

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bindsym $mod+Tab exec "i3CycleWorkspace next"

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bindsym $mod+Shift+Tab exec "i3CycleWorkspace previous"

## Disclaimer
It appears there already exists such a functionality in i3. "workspace next" and "workspace prev" should do
the same as this script.
