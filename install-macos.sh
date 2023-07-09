#!/bin/bash

# Install Virtualbox
brew install virtualbox

# Prompt for the virtual machine path
echo "Enter the virtual machine path:"
read vm_path

# Set the virtual machine path
VBoxManage setproperty machinefolder "$vm_path"

# Install Vagrant
brew install vagrant

# Change directory to $HOME
cd $HOME

# Create Vagrantfile
cat > Vagrantfile <<EOF
Vagrant.configure("2") do |config|
  config.vm.box = "hdnguyen3101/window-10-pro-class"
  config.vm.box_version = "0.1.0"
  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
  end
end
EOF

# Execute the vagrant up command
vagrant up