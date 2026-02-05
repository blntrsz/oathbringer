#! /bin/bash

base_setup() {
  apt update -y &&
  apt upgrade -y
}

PACKAGES=(
  software-properties-common
  git
  ansible
  tmux
  fzf
)

install() {
  apt install -y "${PACKAGES[@]}" &&
  add-apt-repository --yes --update ppa:ansible/ansible
}

clone_repo() {
  rm -rf ~/oathbringer && git clone https://github.com/blntrsz/oathbringer.git ~/oathbringer
}

ansible_run() {
  ansible-playbook ~/oathbringer/local.yaml --ask-become-pass
}

base_setup &&
install &&
clone_repo &&
ansible_run
