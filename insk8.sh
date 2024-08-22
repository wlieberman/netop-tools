#!/bin/bash -x
#
# install k8 master for first time
#
source ./netop.cfg
cd ./install
./insk8master.sh master
./insk8master.sh init
./insk8master.sh calico
./insk8master.sh netop
kubectl get nodes
