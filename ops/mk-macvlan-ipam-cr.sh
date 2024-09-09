# Copyright 2024 NVIDIA
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# https://github.com/Mellanox/network-operator/tree/master/example/crs
#
source ${NETOP_ROOT_DIR}/global_ops.cfg
if [ "$#" -lt 1 ];then
  echo "usage:$0 ${NETWORK_MASTER} {NETWORK IDX}"
  echo "example:$0 ens1f0np0 a"
  exit 1
fi
NDEV=${1}
shift
NIDX=${1}
shift
cat <<EOF> "${NETOP_NETWORK_NAME}-${NIDX}"-cr.yaml
apiVersion: mellanox.com/v1alpha1
kind: ${NETOP_NETWORK_TYPE}
metadata:
  name: ${NETOP_NETWORK_NAME}-${NIDX}
  namespace: ${NETOP_NAMESPACE}
spec:
  networkNamespace: "${NETOP_APP_NAMESPACE}"
  master: "${NDEV}"
  mode: "bridge"
  mtu: 1500
  ipam: |
    {
      "type": "${IPAM_TYPE}",
      "datastore": "kubernetes",
      "kubernetes": {
        "kubeconfig": "/etc/cni/net.d/whereabouts.d/whereabouts.kubeconfig"
      },
      "range": "${NETOP_NETWORK_RANGE}",
      "exclude": [],
      "log_file" : "/var/log/whereabouts.log",
      "log_level" : "info",
      "gateway": "${NETOP_NETWORK_GW}"
    }
EOF
