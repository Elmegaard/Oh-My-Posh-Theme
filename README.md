# Readme

## Update Powershell

The powershell that ships with windows is very old. To update to the latest and make it automatically update:

- Go to Microsoft Store > Poweshell > Get
- Open the Terminal and go to Settings > Startup and change `Default profile` to the new `PowerShell`
- Optionally clean up the terminal drop down
  - In the bottom left of the Settings window, you will see `Open JSON file`, click that and set `"hidden": true` for the old powershell as well as any other command lines you wish to hide from the drop down. Here you can also move the new powershell from the bottom of the list to the top.

## Font

- Download the nerd font from here, which is the same as the default powershell font, but with added icons: https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/CascadiaCode.zip
- Click win+r to open the run window and run `c:/windows/fonts` then drag the new font files into that window to install them.
- Go to Terminal > Settings > Defaults > Apperance
- Change `Font Face` to `CascydiaCove Nerd Font Mono`

## Setup Powershell

Run the `install.ps1` script in the root of this git directory to install all requirements and setup a symbolic link from the powershell profile to the profile in this directory.
