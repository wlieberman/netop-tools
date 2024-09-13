#!/bin/bash -x
#
# restart k8 master
#
source ${NETOP_ROOT_DIR}/global_ops.cfg
cd ${NETOP_ROOT_DIR}/restart
./restartk8master.sh
systemctl start docker
systemctl start containerd
cd ${NETOP_ROOT_DIR}/install
./ins-k8master.sh init
./ins-k8master.sh calico
./ins-k8master.sh netop
kubectl get nodes
