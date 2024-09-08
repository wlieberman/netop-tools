export KUBECONFIG=/etc/kubernetes/admin.conf
swapoff -a
if [ "${NETOP_ROOT_DIR}" = "" ];then
  export NETOP_ROOT_DIR=$(pwd)
fi
