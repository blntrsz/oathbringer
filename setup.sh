#! /bin/sh

apt update -y &&
apt upgrade -y &&
sudo apt install software-properties-common &&
sudo add-apt-repository --yes --update ppa:ansible/ansible &&
apt install -y git ansible &&
git clone https://github.com/blntrsz/oathbringer.git &&
ansible-playbook ~/oathbringer/local.yaml --ask-become-pass

