#!/bin/bash -x
#
# restart k8 master
#
source ./netop.cfg
cd ./restart
./restartk8master.sh
cd ../install
./ins-k8master.sh init
./ins-k8master.sh calico
./ins-k8master.sh netop
kubectl get nodes
