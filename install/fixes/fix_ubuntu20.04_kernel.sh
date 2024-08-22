#!/bin/bash
#
#
apt-get update -y
apt-get remove linux-image-generic-hwe-20.04 -y
apt-get autoremove -y
#and then install fixed version by

apt-get install linux-image-5.4.0-155-generic -y
