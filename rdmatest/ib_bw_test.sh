#!/bin/bash
#
# run from inside of the pods, test RMDA link bandwidth
#
CMD=${1}
shift
case ${CMD} in
s)
  DEV=${1}
  shift
  DEV=`./get_rdma_dev.sh ${DEV}`
  if [ "${DEV}" = "" ];then
  	echo "usage:$0 s {NETDEV}"
  	exit 1
  fi
  ib_write_bw -d ${DEV} -F -R --report_gbits
  ;;
c)
  DEV=${1}
  shift
  SERVER_IP=${1}
  shift
  DEV=`./get_rdma_dev.sh ${DEV}`
  if [ "${DEV}" = "" ] || [ "${SERVER_IP}" = "" ];then
  	echo "usage:$0 c {NETDEV} {SERVER_IP}"
  	exit 1
  fi
  ib_write_bw -d ${DEV} -F -R --report_gbits ${SERVER_IP}
  ;;
*)
	echo "unknown command:${CMD}"
  	echo "usage:$0 s {NETDEV}"
  	echo "usage:$0 c {NETDEV} {SERVER_IP}"
	;;
esac
