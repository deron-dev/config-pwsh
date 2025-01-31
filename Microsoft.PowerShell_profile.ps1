Invoke-Expression (&starship init powershell)

Set-PSReadlineKeyHandler -Key Tab -Function Complete

Function x { exit }

Function gs { git status -u }
Function gg { git log --oneline --graph }
Function gd { git diff }
Function gb { git branch -a }
Function gbd { git branch -a | rg deron }

Function ln {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, Position = 0)]
        [string] $target,

        [Parameter(Mandatory=$true, Position = 1)]
        [string] $link
    )
    $target = Resolve-Path $target
    New-Item -Path $link -ItemType SymbolicLink -Value $target
}

Function cdln ($link) {
    Get-Item $link | Select-Object -ExpandProperty Target | Set-Location
}

Function pwd2 () {
    (Get-Item (Get-Location).Path).FullName | Set-Clipboard
}

$ENV:GIT_SSH="C:\Windows\System32\OpenSSH\ssh.exe"
