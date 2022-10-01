#!/bin/bash

# Check the Effective User ID
if [ "$EUID" -ne 0 ]; then
  echo "Please run script as root."
  exit 1
fi

# Download PGP Key
wget https://www.virtualbox.org/download/oracle_vbox_2016.asc

# Add Key to Keyring
sudo gpg --output /usr/share/keyrings/oracle-virtualbox-2016.gpg --dearmor oracle_vbox_2016.asc

# Create .list File in /etc/apt/sources.list.d/
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib" | sudo tee /etc/apt/sources.list.d/oracle-virtualbox-2016.list

# Update list of packages and install VirtualBox 6.1
sudo apt update
sudo apt install virtualbox-6.1
