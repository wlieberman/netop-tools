#!/bin/bash
#
#
kubectl get nodes -o=custom-columns='NAME:metadata.name,ANNOTATION:metadata.annotations.ipam\.nvidia\.com/ip-blocks'
kubectl get nodes -o=custom-columns='NAME:metadata.name,ANNOTATION:metadata.annotations.'
