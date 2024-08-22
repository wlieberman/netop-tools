#!/bin/bash
#
# https://stackoverflow.com/questions/71218538/how-to-prune-containerd-images-and-containers
#
cd ..
git clone https://github.com/containerd/nerdctl.git
cd nerdctl
make
make install
