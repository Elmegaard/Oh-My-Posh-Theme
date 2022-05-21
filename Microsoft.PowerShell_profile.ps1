using namespace System.Management.Automation
using namespace System.Management.Automation.Language

if ($host.Name -eq 'ConsoleHost')
{
    Import-Module PSReadLine
}
Import-Module -Name Terminal-Icons

oh-my-posh init pwsh --config E:\Git\Oh-My-Posh-Theme\elmegaard.omp.json | Invoke-Expression

function New-Link ($from, $to) {
    New-Item -Path $to -ItemType SymbolicLink -Value $from
}