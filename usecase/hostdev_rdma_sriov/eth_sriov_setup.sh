#!/bin/bash

#echo -n "Restarting openibd..."
#/etc/init.d/openibd restart
#echo "done"

EDEV=${EDEV:-ens1f0}
# MODE can be switchdev/legacy(default)
#MODE=${MODE:-"switchdev"}
MODE=${MODE:-"legacy"}
DEV=`basename $(readlink /sys/class/net/${EDEV}/device)`

DIR=/sys/class/net/${EDEV}/device/sriov
NUMVFS=${NUMVFS:-1}

#echo 0 > /sys/class/net/${EDEV}/device/sriov_numvfs

if [ ${NUMVFS} -ne 0 ];then

    if [ -f /sys/class/net/${EDEV}/device/mlx5_num_vfs ];then
        echo "Using mlx5_num_vfs"
        echo ${NUMVFS} > /sys/class/net/${EDEV}/device/mlx5_num_vfs 
    else
        echo "Using sriov_numvfs"
        echo ${NUMVFS} > /sys/class/net/${EDEV}/device/sriov_numvfs
    fi


    address=$(cat /sys/class/net/${EDEV}/address )

    # create MAC addresses based on current MAC address
    # replace first byte with 0xa, last 50+i in HEX
    for((i=0;i<$NUMVFS;i++));do
        var=`printf "%02x" $i`
        echo $var
        mac=$(echo ${address} | awk -F ':' -v var=$var '{printf("%02x:%s:%s:%s:%s:%s", 0xa, $2, $3, $4, var, $6);}')
        echo "setting device ${EDEV} vf index:$i with MAC:${mac}"
        ip link set dev ${EDEV} vf $i mac ${mac}
    done



    for BDF in ` lspci -D -d 15b3: | awk '/Virtual/ {print $1}'`;do
        echo -n "Unbinding $BDF ..."
        echo ${BDF} > /sys/bus/pci/drivers/mlx5_core/unbind
        echo " $?. done"
    done
fi

echo "Setting eswitch to ${MODE} mode"
devlink dev eswitch set pci/${DEV} mode ${MODE}
sleep 1

if [ ${NUMVFS} -eq 0 ];then
    echo "No VFs to configure"
    exit 0
fi

for BDF in ` lspci -D -d 15b3: | awk '/Virtual/ {print $1}'`;do
    echo -n "Binding $BDF ..."
    echo ${BDF} > /sys/bus/pci/drivers/mlx5_core/bind
    echo " $?. done"
done
for D in `ls -d1 ${DIR}/[0-9]*`;do
    echo "Node for ${D} `cat ${D}/node`"

    if [ -f ${D}/port ] ;then
        echo "Port for ${D} `cat ${D}/port`"
    fi 
#    echo "Policy for ${D} `cat ${D}/policy`"
done
