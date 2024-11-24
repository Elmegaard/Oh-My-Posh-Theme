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
[Environment]::SetEnvironmentVariable("GLAZEWM_CONFIG_PATH", "$PSScriptRoot\glaze\config.yaml", "User")

$zebarDir = "$env:USERPROFILE/.glzr/zebar"
if(Test-Path -Path $zebarDir){
    Remove-Item -Path $zebarDir -Force -Recurse
}
New-Item -Path "$zebarDir" -ItemType SymbolicLink -Value "$PSScriptRoot/glaze/zebar"

winget install JanDeDobbeleer.OhMyPosh --silent
winget install GlazeWM --silent
Install-Module -Name Terminal-Icons -Repository PSGallery
Install-Module PSReadLine -AllowPrerelease -Force

$profileDir = split-path $profile
if(!(Test-Path -Path $zebarDir)){
    New-Item -Path "$profileDir/Microsoft.PowerShell_profile.ps1" -ItemType SymbolicLink -Value "$PSScriptRoot/Microsoft.PowerShell_profile.ps1"
}

Write-Host "Finished Installing everything"
Read-Host