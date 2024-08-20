#!/bin/bash
#
#
#
function syncSriov()
{
  X=`./checksriovstate.sh | grep syncStatus | tr -d [:space:]|cut -d':' -f2`
  while [ "${X}" = "InProgress" ];do
    sleep 5
    printf "."
    X=`./checksriovstate.sh | grep syncStatus | tr -d [:space:]|cut -d':' -f2`
  done
  echo "${X}"
}
syncSriov
