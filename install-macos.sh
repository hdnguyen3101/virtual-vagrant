#!/bin/bash

# Check if Homebrew is installed, install or update it
if ! command -v brew &> /dev/null; then
    # Homebrew is not installed, install it
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    # Homebrew is already installed, update it
    brew update
fi

# Install Virtualbox
brew install --cask virtualbox

# Prompt for the virtual machine path
echo "Enter the virtual machine path:"
read vm_path

# Set the virtual machine path
VBoxManage setproperty machinefolder "$vm_path"

# Install Vagrant
brew install --cask vagrant

# Create Vagrant directory if it doesn't exist
mkdir -p $HOME/Vagrant

# Copy Vagrantfile to $HOME/Vagrant
cp Vagrantfile $HOME/Vagrant/Vagrantfile

# Change directory to $HOME/Vagrant
cd $HOME/Vagrant

# Execute the vagrant up command
vagrant up
