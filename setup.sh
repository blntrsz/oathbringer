#!/usr/bin/env bash

set -euo pipefail

if [[ $EUID -ne 0 ]]; then
  echo "Run this setup as root (for example, curl ... | sudo bash)." >&2
  exit 1
fi

INSTALL_DIR=/opt/oathbringer
BOOTSTRAP_USER=${SUDO_USER:-root}
BOOTSTRAP_HOME=$(getent passwd "$BOOTSTRAP_USER" | cut -d: -f6)
BOOTSTRAP_KEYS="$BOOTSTRAP_HOME/.ssh/authorized_keys"

if [[ ! -s $BOOTSTRAP_KEYS ]]; then
  echo "No SSH keys found for bootstrap user $BOOTSTRAP_USER at $BOOTSTRAP_KEYS." >&2
  exit 1
fi

base_setup() {
  apt update -y &&
  apt upgrade -y
}

PACKAGES=(
  software-properties-common
  git
)

install() {
  apt install -y "${PACKAGES[@]}" &&
  add-apt-repository --yes --update ppa:ansible/ansible &&
  apt install -y ansible
}

clone_repo() {
  rm -rf "$INSTALL_DIR" && git clone https://github.com/blntrsz/oathbringer.git "$INSTALL_DIR"
}

ansible_run() {
  ansible-playbook "$INSTALL_DIR/local.yaml" \
    --extra-vars "bootstrap_authorized_keys_path=$BOOTSTRAP_KEYS"
}

base_setup &&
install &&
clone_repo &&
ansible_run
