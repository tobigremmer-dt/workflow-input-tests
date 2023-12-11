#!/bin/sh
set -e
set -o noglob

ACE_BOX_USER="${ACE_BOX_USER:-$USER}"

# Prevent input prompts by specifying frontend is not interactive
echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

echo "INIT - Update apt-get and upgrade already install packages..."
apt-get update && apt-get dist-upgrade -y

echo "INIT - Setting up Python..."
apt-get install python3-pip -y

# Upgrade pip
python3 -m pip --version
python3 -m pip install --upgrade pip -q

# Ansible
echo "INIT - Installing Ansible..."
python3 -m pip install ansible
ln -s /home/$ACE_BOX_USER/.local/bin/ansible /usr/bin/ansible
ln -s /home/$ACE_BOX_USER/.local/bin/ansible-galaxy /usr/bin/ansible-galaxy
ln -s /home/$ACE_BOX_USER/.local/bin/ansible-playbook /usr/bin/ansible-playbook

# echo "ACE-Box version $ACE_BOX_VERSION will be deployed"
