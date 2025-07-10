#! /usr/bin/bash

if (( $# > 1 )) then 
	echo "Unsupported number of arguments"
	echo $#
	exit 1
fi

if [ $# == 0 ]; then 
	old_mode=$(cat /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode)
	target_mode=$((($old_mode + 1) % 2))
	echo $target_mode > /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode 
	new_mode=$(cat /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode)
	target_string=$([ "$target_mode" == 0 ] && echo "down" || echo "up")
	if [ $new_mode != $target_mode ]; then 
		echo "Could not set mode to ${target_string}"
		exit 1
	fi
	echo "Mode set to ${target_string}"
	exit 0
fi

if [ $1 == "down" ]; then 
	echo 0 > /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode 
	new_mode=$(cat /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode)
	if [ $new_mode != 0 ]; then
		echo "Could not set mode to down"
	else 
		echo "Mode set to down"
	fi
elif [ $1 == "up" ]; then 
	echo 1 > /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode 
	new_mode=$(cat /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode)
	if [ $new_mode != 1 ]; then
		echo "Could not set mode to up"
	else 
		echo "Mode set to up"
	fi
fi

