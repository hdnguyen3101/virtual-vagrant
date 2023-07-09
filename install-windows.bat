@echo off

REM Check if Chocolatey is installed, install or update it
where choco > nul 2>&1
if %errorlevel% neq 0 (
    REM Chocolatey is not installed, install it
    @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
) else (
    REM Chocolatey is already installed, update it
    choco upgrade chocolatey -y
)

REM Install Virtualbox
choco install virtualbox -y

REM Prompt for the virtual machine path
echo Enter the virtual machine path:
set /p vm_path=

REM Set the virtual machine path
REG ADD "HKLM\SOFTWARE\Oracle\VirtualBox" /v "Global\DefaultMachineFolder" /t REG_SZ /d "%vm_path%" /f

REM Install Vagrant
choco install vagrant -y

REM Change directory to %USERPROFILE%
cd /d "%USERPROFILE%"

REM Create Vagrant folder
mkdir Vagrant
cd Vagrant

REM Create Vagrantfile
(
  echo Vagrant.configure("2") do ^|config^|
  echo   config.vm.box = "hdnguyen3101/window-10-pro-class"
  echo   config.vm.box_version = "0.1.0"
  echo   config.vm.provider "virtualbox" do ^|vb^|
  echo     vb.gui = true
  echo   end
  echo end
) > Vagrantfile

REM Execute the vagrant up command
vagrant up
