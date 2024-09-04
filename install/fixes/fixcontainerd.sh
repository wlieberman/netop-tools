#!/bin/bash
#
# https://github.com/containerd/containerd/issues/6009
#
CONTAINERD_CONFIG=/etc/containerd/config.toml

containerd config default | sudo tee $CONTAINERD_CONFIG
sed -i 's#SystemdCgroup =.*#SystemdCgroup = true#' $CONTAINERD_CONFIG
sed -i 's#sandbox_image = "registry.k8s.io/pause:3.8"#sandbox_image = "registry.k8s.io/pause:3.10"#' $CONTAINERD_CONFIG
systemctl restart containerd
systemctl restart kubelet
