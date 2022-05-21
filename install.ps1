param([switch]$Elevated)

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

if ((Test-Admin) -eq $false) {
    if ($elevated) {
        # tried to elevate, did not work, aborting
    }
    else {
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
    }
    exit
}

winget install oh-my-posh
Install-Module -Name Terminal-Icons -Repository PSGallery

$profileDir = split-path $profile
New-Item -Path "$profileDir/Microsoft.PowerShell_profile.ps1" -ItemType SymbolicLink -Value "$PSScriptRoot/Microsoft.PowerShell_profile.ps1"