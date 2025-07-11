# Lenovo ACPI controller

This is a short shell script i wrote to control the battery conservation mode on a Lenovo laptop through the ACPI VPC2004 driver.
Might add more ACPI functionality later, but for now this is all I needed.

## Usage
```
sudo ./lacpi.sh bcm
```
This command toggles the battery conservation mode. 
```
sudo ./lacpi.sh bcm up/down
```
The optional argument up/down lets you set the mode explicitly.

