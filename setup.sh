#! /bin/sh

base_setup() {
  apt update -y &&
  apt upgrade -y
}

install() {
  sudo apt install software-properties-common &&
  sudo add-apt-repository --yes --update ppa:ansible/ansible &&
  apt install -y git ansible
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
