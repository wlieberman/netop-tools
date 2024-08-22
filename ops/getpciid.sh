#!/bin/bash
#
#
#
grep PCI_ID /sys/bus/pci/devices/*/uevent | grep "=15B3"
