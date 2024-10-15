netop-tools provides a set op Network-Operator configuration automation scripts.
netop-tools simplifies the configuration of common Network-Operator use cases.
git clone https://github.com/thuffmlx/netop-tools.git
cd ./netop-tools
git checkout master
source “NETOP_ROOT_DIR.sh”                   # create the NETOP_ROOT_DIR env variable.
global_ops.cfg file defines the shared global configuration values for Network-Operator.
Edit the global_ops.cfg setting K8s networking parameters and selecting the USECASE.
./setuc.sh                                   # set the uc symlink for the selected USECASE
cd ./uc                                      # edit the netop.cfg for the use case specific configuration
cd ${NETOP_ROOT_DIR}; ./ins-k8.sh            # installs os specific K8s Network-Operator and dependencies on a bare metal control plane.
kubectl get pods –A                          # verify that the Network-Operator pods are ready for applying the network configuration
cd ./uc; ./apply-network-cr.sh               # use global_ops.cfg (includes {USECASE}/netop.cfg) to apply the use case specific network resources
./installapp.sh test                         # install the sample app and use kubectl get pods –A to check the pod status
