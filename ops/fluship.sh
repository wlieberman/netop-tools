#!/bin/bash
#
#
systemctl stop kubelet
#systemctl stop crio
iptables --flush
iptables -tnat --flush
systemctl start kubelet
#systemctl start crio
