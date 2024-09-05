#!/bin/bash
#
#
source ./${NETOP_ROOT_DIR}/global_ops.cfg
cd /etc/ssl/certs
# <Release_Name>-webhook-service.<Release_Namespace>.svc
SVCNAME="network-operator-${NETOP_VERSION}-webhook-service.${NETOP_NAMESPACE}.svc"
openssl req -x509 -nodes -batch -newkey rsa:2048 -keyout server.key -out server.crt -days 365 -addext "subjectAltName=DNS:$SVCNAME"
