#!/bin/bash
#
# run on the worker nodes
#
NUMVFS=${1}
shift
for BDF in ${*};do
  PATH=$(find /sys -name sriov_numvfs -exec echo {} \;| grep "${BFD}" )
  if [ "${PATH}" != "" ];then
    echo "${NUMVFS}" > ${PATH}
  else
    echo "WARNING:Not Found:${BFD}"
  fi
done
