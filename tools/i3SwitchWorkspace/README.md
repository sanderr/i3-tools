# i3SwitchWorkspace
## Introduction
This directory contains a script to switch between workspaces in a multi-monitor environment.
It assumes i3 workspaces are named with a number, followed by a colon, and the xrandr name (or an alias, as explained at the top of the script)
of the output the workspace is on. For example 0:DP-1 or 7:p.

The purpose of this script is to make easy to map i3 key combinations to switching to workspace on primary, secondary, tertiary,... output,
even when the connected outputs change dynamically. You can for example, map a key combination to "i3SwitchWorkspace.sh --workspace 4 --output-number 2",
then use your laptop connected to an HDMI screen at work, which makes the HDMI-0
output the secondary output. Pressing the key combination would then result in switching to workspace 4:HDMI-0. When you come home, you plug the laptop in your docking station,
which might make DP-1 your secondary output. Pressing the key combination would then result in switching to workspace 4:DP-1, without requiring you to change your i3 config.

## i3 config
To use this script, you should bind the desired workspaces to their corresponding outputs in your i3 config. For example:

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;workspace 4:LVDS1 output LVDS1

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;workspace 4:HDMI-0 output HDMI-0

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;workspace 4:DP-1 output DP-1

This makes sure that when i3 switches to workspace 4:HDMI-0, the workspace appears on output HDMI-0. LVDS1 is the xrandr name of my laptop's primary output. I'm not
sure if this is generic, you should check yours.

If you prefer, you could use aliases for the outputs, for example d for DisplayPort, h for HDMI, p for primary laptop screen.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;workspace 4:p output LVDS1

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;workspace 4:h output HDMI-0

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;workspace 4:d output DP-1


## output preference
You can also order outputs by preference. If you would for example call "i3SwitchWorkspace.sh --preferred-outputs LVDS1 DP-1 DVI-D-1 DVI-I-1 HDMI-1 --output-number 2 --workspace 4"
the connected outputs are ordered in the order you supplied, so if all above displays were connected, LVDS1 would be seeen as primary, DP-1 as secondary and so on. But if only LVDS1 and HDMI-1 are connected,
HDMI-1 is seen as the secondary output.
The same can be accomplished with aliases, for example:

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;i3SwitchWorkspace.sh --preferred-outputs LVDS1,p DP-1,d DVI-D-1,dD DVI-I-1,dI HDMI-1,h --output-number 1 --workspace 4

## example
An example of i3 config lines can be found in example/config. This might not work out of the box for everyone, but it should if you make sure the variables at the top are set to the correct values for your system.
