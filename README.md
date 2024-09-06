# netop-tools
tools to install and configure nvidia network operator based on use cases
download repo
from netop-tools run:
source ./k8envroot.sh
./setuc.sh
edit ./global_ops.cfg to set global config
edit ./uc/netop.cfg to set usecase config
# install system on control plane node
./ins-k8.sh
need to document details.
