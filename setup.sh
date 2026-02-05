#! /bin/sh

base_setup() {
  apt update -y &&
  apt upgrade -y
}

install() {
  apt install -y "$(cat packages.txt)" &&
  add-apt-repository --yes --update ppa:ansible/ansible &&
  apt install -y $(cat packages.txt | tail -n +2)
}

clone_repo() {
  rm -rf ~/oathbringer && git clone https://github.com/blntrsz/oathbringer.git
}

ansible_run() {
  ansible-playbook ~/oathbringer/local.yaml --ask-become-pass
}

base_setup &&
install &&
clone_repo &&
ansible_run
