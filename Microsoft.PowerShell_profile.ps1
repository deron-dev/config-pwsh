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

# let emulator know what CWD is
# https://wezfurlong.org/wezterm/shell-integration.html#osc-7-on-windows-with-powershell
$prompt = ""
function Invoke-Starship-PreCommand {
    $current_location = $executionContext.SessionState.Path.CurrentLocation
    if ($current_location.Provider.Name -eq "FileSystem") {
        $ansi_escape = [char]27
        $provider_path = $current_location.ProviderPath -replace "\\", "/"
        $prompt = "$ansi_escape]7;file://${env:COMPUTERNAME}/${provider_path}$ansi_escape\"
    }
    $host.ui.Write($prompt)
}

Invoke-Expression (&starship init powershell)
