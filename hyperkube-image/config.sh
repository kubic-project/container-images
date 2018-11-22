#!/bin/bash

#======================================
# Functions...
#--------------------------------------
test -f /.kconfig && . /.kconfig
test -f /.profile && . /.profile

#======================================
# Greeting...
#--------------------------------------
echo "Configure image: [$kiwi_iname]..."

#======================================
# Imitate upstream image:
# k8s.gcr.io/debian-hyperkube-base-amd64
# same file structure
#--------------------------------------
cp /usr/bin/hyperkube /hyperkube
ln -s /hyperkube apiserver
ln -s /hyperkube cloud-controller-manager
ln -s /hyperkube controller-manager
ln -s /hyperkube kubectl
ln -s /hyperkube kubelet
ln -s /hyperkube proxy
ln -s /hyperkube scheduler

exit 0
