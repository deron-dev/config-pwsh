oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\onehalf.minimal.omp.json" | Invoke-Expression

# make tab completion not bad
Set-PSReadlineKeyHandler -Key Tab -Function Complete

Function x { exit }

Function gs { git status -u }
Function gg { git log --oneline --graph }
Function gd { git diff }
Function gb { git branch -a }
Function gbd { git branch -a | rg deron }

Function ln ($target, $link)
{
    New-Item -Path $link -ItemType SymbolicLink -Value $target
}

Function cdln ($link)
{
    Get-Item $link | Select-Object -ExpandProperty Target | Set-Location
}

$ENV:GIT_SSH="C:\Windows\System32\OpenSSH\ssh.exe"
