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
        Start-Process pwsh.exe -Verb RunAs -ArgumentList ('-noprofile -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
    }
    exit
}

[Environment]::SetEnvironmentVariable("OhMyPoshThemeDirectory", $PSScriptRoot, "User")

winget install JanDeDobbeleer.OhMyPosh
Install-Module -Name Terminal-Icons -Repository PSGallery
Install-Module PSReadLine -AllowPrerelease -Force

$profileDir = split-path $profile
New-Item -Path "$profileDir/Microsoft.PowerShell_profile.ps1" -ItemType SymbolicLink -Value "$PSScriptRoot/Microsoft.PowerShell_profile.ps1"

Read-Host