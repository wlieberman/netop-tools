#!/bin/bash -x
#
# use whereabouts install of ipam for small clusters
#
source ./netop.cfg
cat << HEREDOC > ./whereabouts.yaml
apiVersion: mellanox.com/v1alpha1
kind: ${NETOP_NETWORK_TYPE}
metadata:
  name: ${NETOP_NETWORK}
spec:
  networkNamespace: "${NETOP_APP_NAMESPACE}"
  resourceName: "${NETOP_NETWORK}"
  ipam: |
    {
      "type": "${IPAM_TYPE}",
      "datastore": "kubernetes",
      "kubernetes": {
        "kubeconfig": "/etc/cni/net.d/whereabouts.d/whereabouts.kubeconfig"
      },
      "range": ${NETOP_NETWORK_RANGE},
      "exclude": [],
      "log_file" : "/var/log/whereabouts.log",
      "log_level" : "info"
    }
HEREDOC
cat ./whereabouts.yaml
