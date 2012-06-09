#/////////////////////////////////////////////////////////////////////////////////////////////////////////////
#-------------------------------------------------------------------------------------------------------------
# Las Vegas Sands Corporation
# Grazie Loyalty Kiosk
# Loyalty Card Printing Scripts
#-------------------------------------------------------------------------------------------------------------
# This script sends the necessary commands to the Datacard CP60 printer for re-printing a guest's Grazie
# Loyalty Card. The script takes two (2) parameters:
#   1. [string] $name - the guest's name
#   2. [string] $accountNumber - the guest's account number
#
# CARD SCAN FORMAT
#-------------------------------------------------------------------------------------------------------------
# Once the script has run, the printer will print a card with the guest's name and account number; it will also
# encode the magnetic strip with the proper information:
# 
# %V1<Guest Name><5 spaces><Account Number>20801?;<Account Number>20801?
# 
# INVOCATION FROM CONTENT MANAGER
#-------------------------------------------------------------------------------------------------------------
# Invocation of this script from FWi Content Manager will take the following form:
# 
#   Content.Execute("IsShellCommand=true", "PowerShell -Command "& ""C:\Users\Public\Documents\Four Winds Interactive\Signage\Content\lvsc-print-card.ps1""", "{&var:GuestName}", {&var:AccountNumber});
# 
# CARD SCAN FORMAT
#-------------------------------------------------------------------------------------------------------------
# The printer will be sent the template defined by the $templateFilePath variable below.
#-------------------------------------------------------------------------------------------------------------
#/////////////////////////////////////////////////////////////////////////////////////////////////////////////

# Collect command-line parameters
param (
  [string] $name,
  [string] $accountNumber
)

# GLOBAL VARIABLES - EDIT BELOW IF NECESSARY
#-------------------------------------------------------------------------------------------------------------
[string] $destinationDirectory = $([Environment]::GetEnvironmentVariable("TEMP", "User"))
[string] $outputFilePrefix     = "KioskCard"
[string] $templateFilePath     = "Z:\Macintosh HD\Users\abach\Downloads\test.txt"
[string] $file2prnPath         = "Z:\Macintosh HD\Users\abach\Downloads\Windows\file2prn.exe"
#-------------------------------------------------------------------------------------------------------------

# Make sure all of our parameters are present; if not, exit the script
if (!$name -or !$accountNumber) {
	write-output "Usage: $($MyInvocation.MyCommand.Path)  [Guest Name] [Account Number]"
	return
}

# Create a new (hopefully unique) file to store our template
[string] $timestamp = $(Get-Date -f "yyyyMMddHHmmss")
[string] $tmpFile = New-Item -path "$destinationDirectory" -name "$outputFilePrefix-$timestamp.txt" -type file

# Loop through our template file and replace placeholders with our parameters
(Get-Content $templateFilePath) | Foreach-Object { 
  $_ -replace "<Guest Name>", "$name" -replace "<Account Number>", "$accountNumber" 
} | Set-Content $tmpFile

# ...

# Once we're done, remove the temporary template file we created
Remove-Item -path "$tmpFile" -force