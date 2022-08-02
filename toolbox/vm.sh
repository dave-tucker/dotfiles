#!/bin/sh

set -e


if [ ! -f "${HOME}/.ssh/id_rsa.pub" ]; then
    ssh-keygen -t rsa -b 4096 -f "${HOME}/.ssh/id_rsa" -N "" -C "" -q
fi

IMAGE="Fedora-Cloud-Base-36-1.5.x86_64.qcow2"
if [ ! -f "/var/lib/libvirt/isos/${IMAGE}" ]; then
    sudo mkdir -p /var/lib/libvirt/isos
    sudo chown -R qemu:qemu /var/lib/libvirt/isos
    IMAGE_URL="https://download.fedoraproject.org/pub/fedora/linux/releases/35/Cloud/x86_64/images"
    echo "Downloading: ${IMAGE}, this may take a while..."
    curl -o "/var/lib/libvirt/isos/${IMAGE}" -sSL "${IMAGE_URL}/${IMAGE}"
fi

create_vm() {
    name=$1
    if [ -z "${name}" ]; then
        echo "name is required"
        exit 1
    fi
    tmpdir=$(mktemp -d)
    cat > "${tmpdir}/meta-data.yaml" <<EOF
instance-id: ${name}
local-hostname: ${name}
EOF

    pub_key=$(cat "${HOME}/.ssh/id_rsa.pub")
    cat > "${tmpdir}/user-data.yaml" <<EOF
#cloud-config
repo_update: true
repo_upgrade: all

packages:
 - zsh
 - git

users:
  - name: dave
    gecos: Dave Tucker
    sudo: ALL=(ALL) NOPASSWD:ALL
    groups: wheel
    shell: /usr/bin/zsh
    plain_text_passwd: 'iamgroot'
    lock_passwd: true
    ssh_authorized_keys:
      - ${pub_key}
EOF

    cat "${tmpdir}/user-data.yaml"

    virt-install --name ${name} \
    --connect qemu:///system \
    --memory 4000 \
    --network=default \
    --os-variant detect=on,name=fedora-unknown \
    --cloud-init meta-data="${tmpdir}/meta-data.yaml",user-data="${tmpdir}/user-data.yaml" \
    --disk=size=60,backing_store="/var/lib/libvirt/isos/${IMAGE}" \
    --noautoconsole

    rm -rf "${tmpdir}"
}

create_vm dev