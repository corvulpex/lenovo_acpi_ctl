#! /bin/bash

if [ $# == 0 ]; then 
	echo "No controller specified"
	exit 1
fi

display_help() {
	echo "---Lenovo ACPI Controller---"
	echo "Usage:" 
	echo "   $(basename $0) bcm [up | down]"
	echo "	    Toggles the ideapad_acpi battery conservation mode"
	echo "	    Optionally add up/down to set mode explicitly"
	echo ""
}

battery_conservation_control () {
	
	if [[ $# == 1 ]]; then 
		old_mode=$(cat /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode)
		target_mode=$((($old_mode + 1) % 2))
		echo $target_mode > /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode 
		new_mode=$(cat /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode)
		target_string=$([ "$target_mode" == 0 ] && echo "down" || echo "up")
		if [ $new_mode != $target_mode ]; then 
			echo "Could not set battery conservation to ${target_string}"
			exit 1
		fi
		echo "Battery conservation set to ${target_string}"
		return
	fi

	if [[ $2 == "down" ]]; then 
		echo 0 > /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode 
		new_mode=$(cat /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode)
		if [ $new_mode != 0 ]; then
			echo "Could not set battery conservation to down"
		else 
			echo "Battery conservation set to down"
		fi
		return
	fi
	
	if [[ $2 == "up" ]]; then 
		echo 1 > /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode 
		new_mode=$(cat /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode)
		if [ $new_mode != 1 ]; then
			echo "Could not set battery conservation to up"
		else 
			echo "Battery conservation set to up"
		fi
		return	
	fi

	echo "Options for battery conservation control could not be interpreted correctly"
	exit 1
}

if [[ $1 == "-h" || $1 == "--help" ]]; then 
	display_help 
	exit 0
fi

if [[ $1 == "bcm" ]]; then 
	battery_conservation_control $@
	exit 0
fi


echo "No commands except bcm supported yet"
exit 1
