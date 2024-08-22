#!/bin/bash
#
#
helm list --all-namespaces
#helm delete network-operator -n network-operator
helm delete ${1} -n ${2}
helm list --all-namespaces
