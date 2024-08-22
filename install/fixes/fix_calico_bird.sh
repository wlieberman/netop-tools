#!/bin/bash
#
#
#@DFanso I've opened port 179 to establish the BIRD communication between the nodes.
#IPTABLES rule:
#iptables -A INPUT -s ${1} -p tcp -m tcp --dport 179 -j ACCEPT
iptables -A INPUT -s 0.0.0.0 -p tcp -m tcp --dport 179 -j ACCEPT


