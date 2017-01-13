#!/bin/bash
#
# Switches i3 workspace.
#
# Usage:
#	./i3SwitchWorkspace.sh --workspace workspace [OPTIONS]
#
#	OPTIONS:
#		--move:
#			Moves the current container to the specified workspace instead of switching to it.
#		--preferred-outputs
#			Space seperated list of preferred outputs, in order of preference.
#			An output can be just the name of the output, or the name and an alias,
#			seperated by comma, no space (e.g. DP1,d)
#			If an alias is specified, the alias will be used for the naming of the workspace
#		--output-number
#			The number of the output to use, as currently connected, and listed in --preferred-outputs, starting with 1

move=false
workspace=""
outputs=()
outputNumber=1

while getopts :-: opts; do
	case $opts in
		-)
			case $OPTARG in
				move)
					move=true
					OPTIND=$(( $OPTIND + 1 ))
					;;
				workspace)
					argument=${!OPTIND}
					if [ -z "$argument" ]; then
						echo "No parameter specified to --$OPTARG." >&2
						exit
					fi
					workspace=$argument
					OPTIND=$(( $OPTIND + 1 ))
					;;
				preferred-outputs)
					argument=${!OPTIND}
					while [ ! -z $argument ] && [[ $argument != -* ]]; do
						outputs+=($argument)
						OPTIND=$(( $OPTIND + 1 ))
						argument=${!OPTIND}
					done
					;;
				output-number)
					argument=${!OPTIND}
					if [ -z "$argument" ]; then
						echo "No parameter specified to --$OPTARG." >&2
						exit
					fi
					outputNumber=$argument
					OPTIND=$(( $OPTIND + 1 ))
					;;
				*)
					echo "Invalid option: --$OPTARG." >&2
					exit
					;;
			esac
			;;
		*)
			echo "Invalid option: -$OPTARG." >&2
			exit
			;;
	esac
done

if [ -z ${workspace[0]} ]; then
	echo "no workspace supplied" >&2
	exit
fi

available=$(xrandr --query | grep -B 1 *+ | grep ' connected')
if [ -z ${outputs[0]} ]; then
	output=$(echo "$available" | sed -n '2 p')
else
	count=0
	for i in ${outputs[@]}; do
		IFS=',' read -ra output <<< "$i"
		name=${output[0]}
		alias=${output[1]}
		xrandrOutput=$(echo "$available" | grep "$name")
		if [ ! -z "$xrandrOutput" ]; then
			count=$(( $count + 1 ))
		fi
		if [ $count -eq $outputNumber ]; then
			break
		fi
		echo "done"
	done
	if [ -z "$alias" ]; then
		output=$name
	else
		output=$alias
	fi
fi
if [ -z $output ]; then
	echo "No output found for the specified options" >&2
	exit
fi

i3Command="workspace $workspace:$output"
if [ "$move" = true ]; then
	i3Command="move container to $i3Command"
fi
i3-msg "$i3Command"
