#!/bin/bash
#
#
#
DIR="${1}"
shift
for FILE in ${*};do
  DIFFILE="${FILE}.dif"
  diff -b "${FILE}" "${DIR}/${FILE}" > "${DIFFILE}"
  if [ -s "${DIFFILE}" ];then
    echo "${DIFFILE}"
  else
    rm -f "${DIFFILE}"
  fi
done
