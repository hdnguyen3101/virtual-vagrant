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
set /p vm_path="Enter the virtual machine path: "

REM Set the virtual machine path
REG ADD "HKLM\SOFTWARE\Oracle\VirtualBox" /v "Global\DefaultMachineFolder" /t REG_SZ /d "%vm_path%" /f

REM Install Vagrant
choco install vagrant -y

REM Create Vagrant directory if it doesn't exist
mkdir %USERPROFILE%\Vagrant

REM Copy Vagrantfile to %USERPROFILE%\Vagrant
copy Vagrantfile %USERPROFILE%\Vagrant\Vagrantfile

REM Change directory to %USERPROFILE%\Vagrant
cd /d %USERPROFILE%\Vagrant

REM Execute the vagrant up command
vagrant up
