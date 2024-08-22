#!/bin/bash
#
# https://github.com/containerd/containerd/issues/6009
#
containerd config default | sudo tee /etc/containerd/config.toml
sed -i 's/SystemdCgroup =.*/SystemdCgroup = true/' /etc/containerd/config.toml
systemctl restart containerd
systemctl restart kubelet
