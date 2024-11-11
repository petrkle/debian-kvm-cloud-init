#!/bin/bash

set -e

NAME=debian12
RAM=2048
CPU=2
DISK=10G

[ -f debian-12-generic-amd64.qcow2 ] || wget https://cdimage.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2

qemu-img create -u -b debian-12-generic-amd64.qcow2 -f qcow2 -F qcow2 "${NAME}.img" ${DISK}

echo "instance-id: ${NAME}
local-hostname: ${NAME}" > meta-data

mkisofs -output cidata.iso -V cidata -r -J user-data meta-data

virt-install \
  --connect qemu:///system \
  --name="${NAME}" \
  --ram=${RAM} \
  --vcpus=${CPU} \
  --import \
  --disk path=${NAME}.img,format=qcow2 \
  --disk path=cidata.iso,device=cdrom \
  --os-variant=debian12 \
  --network network=default,model=virtio \
  --graphics vnc,listen=0.0.0.0 \
  --noautoconsole
