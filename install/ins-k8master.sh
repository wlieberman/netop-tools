#!/bin/bash -x
#
# install network operator master node
#
source ./netop.cfg
CMD="${1}"
shift
case "${CMD}" in
master)
  systemctl mask swap.target # permanently turn off swap
  ./ins-helm.sh
  ./ins-k8repo.sh
  ./ins-go.sh
  ./ins-k8base.sh
  ./ins-docker.sh
  ;;
init)
  kubeadm init --pod-network-cidr=${K8CIDR}
  source ../k8envroot.sh
  # ./fixes/fix config issues
  ./fixes/fixcrtauth.sh
  ./fixes/fixcontainerd.sh 
  ./configcrictl.sh
  #./ins-multus.sh
  ;;
calico)
  source ../k8envroot.sh
  ./wait-k8sready.sh
  ./ins-calico.sh
  ./ins-calicoctl.sh
  ;;
netop)
  source ../k8envroot.sh
  ./wait-calicoready.sh
  # setup helm charts
  ./ins-netop-chart.sh
  ./ins-network-operator.sh
  ;;
app)
  source ../k8envroot.sh
  #
  # deploy app
  #
  if [ "${1}" = "" ];then
    echo "error:missing appname:${1}"
    echo "install app usage:$0 app {APPNAME}"
    exit 1
  fi
  ./insapp.sh ${1}
  ;;
worker)
  if [ "${1}" = "" ];then
    echo "error:missing worker node:${1}"
    echo "install work usage:$0 worker {NODENAME}"
    exit 1
  fi
  # install a node, apply a label to the node
  ./ops/labelworker.sh ${1}
  ;;
debug)
  # debug tools
  ./inskubectx.sh
  ./insnerdctl.sh
  ;;
*)
  echo "error:unknown command:${CMD}"
  echo "install master node usage:$0 master"
  echo "install worker node label usage:$0 worker {WORKERNODE}"
  echo "install sriov setup  usage:$0 sriov"
  echo "install app usage:$0 app {APPNAME}"
  exit 1
  ;;
esac
