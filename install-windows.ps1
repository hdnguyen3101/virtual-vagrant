# Install Chocolatey (Package Manager for Windows)
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install VirtualBox
choco install virtualbox -y

# Prompt for the virtual machine path
Write-Host "Enter the virtual machine path:"
$vmPath = Read-Host

# Set the virtual machine path
Set-ItemProperty -Path "HKLM:\SOFTWARE\Oracle\VirtualBox" -Name "Global\DefaultMachineFolder" -Value $vmPath

# Install Vagrant
choco install vagrant -y

# Change directory to $HOME
Set-Location $HOME

# Create Vagrantfile
@"
Vagrant.configure("2") do |config|
  config.vm.box = "hdnguyen3101/window-10-pro-class"
  config.vm.box_version = "0.1.0"

  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
  end
end
"@ | Out-File -FilePath "Vagrantfile" -Encoding utf8

# Execute the vagrant up command
vagrant up
