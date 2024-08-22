#!/bin/bash
#
# must be configured to use crictl to read docker container info
# run on each node that you want to inspect containers on at the node level.
#
cat << HEREDOC > /etc/crictl.yaml
runtime-endpoint: unix:///var/run/containerd/containerd.sock
image-endpoint: unix:///var/run/containerd/containerd.sock
timeout: 30
debug: true
pull-image-on-create: false
disable-pull-on-run: false
HEREDOC
