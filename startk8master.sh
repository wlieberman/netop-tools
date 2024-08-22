#!/bin/bash -x
#
# restart k8 master
#
source ./netop.cfg
cd ./restart
./restartk8master.sh
cd ../install
./insk8master.sh init
./insk8master.sh calico
./insk8master.sh netop
kubectl get nodes
