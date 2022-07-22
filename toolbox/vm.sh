#!/bin/sh

set -e

virt-install --name aya \
    --connect qemu:///system \
    --memory 2000 \
    --network 
    --os-variant detect=on,name=fedora-unknown \
    --cloud-init clouduser-ssh-key="/home/dave/.ssh/id_rsa.pub" \
    --disk=size=30,backing_store="/var/lib/libvirt/isos/Fedora-Cloud-Base-36-1.5.x86_64.qcow2" \
    --noautoconsole
