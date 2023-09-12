# Get the computer's serial number
$serialNumber = Get-WmiObject -Class Win32_Bios | Select-Object -ExpandProperty SerialNumber

#Declare PCS's computer
$PCSComputer = "PCS"

#Declare Prefix LP or DP
$LaptopPrefix = "LP"
$DesktopPrefix = "DP"

# Get the current computer name
$currentComputerName = $env:COMPUTERNAME

# Check if it's a laptop or desktop | $computerType.

$computerType = $DesktopPrefix # Default Desktop 
if ((Get-WmiObject -Class Win32_SystemEnclosure).ChassisTypes -contains 10) {
    $computerType = $LaptopPrefix  # If it's a laptop, then change it. Note: 10 is Notebook.
}
# Create new computer name
$newComputerName = "$PCSComputer-${serialNumber}-$computerType"

# Set new computer name
Rename-Computer -NewName $newComputerName -Force
New-Item -Path "C:\ChangeComputerNameVer2Successful.txt"