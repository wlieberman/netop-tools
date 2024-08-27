#!/bin/bash -x
#
#
function nsReady()
{
  READY=0
  while [ "${READY}" = "0" ];do
    READY=1
    for POD in ${PODLIST[@]};do
      CNT=`echo ${POD} | cut -d, -f1`
      NS=`echo ${POD} | cut -d, -f2`
      NAME=`echo ${POD} | cut -d, -f3`
      RCNT=`kubectl get pods -n ${NS} | tr -s [:space:] | cut -d' ' -f1,3 | grep "${NAME}" | grep -c Running`
      if [ "${RCNT}" -lt "${CNT}" ];then
        READY=0
        break
      fi
    done
    if [ "${READY}" = "0" ];then
      sleep 10
    fi
  done
  echo "READY"
}
