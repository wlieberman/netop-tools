#!/bin/bash
#
#
if [ ! -d ./multus-cni ];then
  git clone https://github.com/k8snetworkplumbingwg/multus-cni.git
fi
cd multus-cni
# We'll apply a YAML file with kubectl from this repo, which installs the Multus components.
#
# Recommended installation:
#
cat ./deployments/multus-daemonset-thick.yml | kubectl apply -f -

# See the thick plugin docs for more information about this architecture.
# 
# Alternatively, you may install the thin-plugin with:
# 
# cat ./deployments/multus-daemonset.yml | kubectl apply -f -
