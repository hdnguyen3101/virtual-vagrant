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