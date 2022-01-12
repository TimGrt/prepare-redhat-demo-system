#!/bin/sh

# This script is intended to run in the home directory of the attendee!
# It will break the intially working SSH connection to the managed nodes, this should
# be fixed as part of the workshop.
# It also removes a line from the default ansible.cfg

# Own .ssh/config should not be used, move/rename the file
if [ -f ~/.ssh/config ]; then
  mv ~/.ssh/config ~/.ssh/config.bak
fi

# Delete line with 'stdout_callback' from default ansible.cfg, this prevents attendees to use Ansible directly
sudo sed -i '/stdout_callback*/d' /etc/ansible/ansible.cfg

# Delete [all:vars] block from inventory file
#sudo sed '/^\[all:vars\][^[]+/d' ~/lab_inventory/hosts
sudo sed -i -e '/^\[all:vars\]/d' -e '/^ansible_/d' -e '0,/^$/{//d}' ~/lab_inventory/hosts

# Create a public key from the existing private key
ssh-keygen -f ~/.ssh/id_rsa -y > ~/.ssh/id_rsa.pub

