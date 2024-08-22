#!/bin/bash -x
#
# restart k8 master
#
source ./netop.cfg
./insk8master.sh master
./insk8master.sh init
#./insk8master.sh calico
#./insk8master.sh netop
#./insk8master.sh debug
kubectl get nodes
