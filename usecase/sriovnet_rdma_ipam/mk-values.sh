#!/bin/bash
#
#
source ${NETOP_ROOT_DIR}/global_ops.cfg
cat <<HEREDOC1>./values.yaml
nfd:
  enabled: true
sriovNetworkOperator:
  enabled: true
HEREDOC1
if [ "${PROD_VER}" = "0" ];then
cat <<HEREDOC2>>./values.yaml
  imagePullSecrets: [ngc-image-secret]   # <- specify your created pull secrets for ngc private repo

# NicClusterPolicy CR values:
imagePullSecrets: [ngc-image-secret]   # <- specify your created pull secrets for ngc private repo
HEREDOC2
fi
cat <<HEREDOC3>>./values.yaml
deployCR: true
nvIpam:
  deploy: false

ofedDriver:
  deploy: true
  env:
  - name: RESTORE_DRIVER_ON_POD_TERMINATION
    value: "true"
  - name: UNLOAD_STORAGE_MODULES
    value: "true"
  - name: CREATE_IFNAMES_UDEV
    value: "true"
rdmaSharedDevicePlugin:
  deploy: false

sriovDevicePlugin:
  deploy: false

secondaryNetwork:
  deploy: true
  multus:
    deploy: true
  cniPlugins:
    deploy: true
  ipamPlugin:
    deploy: true
HEREDOC3
