oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\onehalf.minimal.omp.json" | Invoke-Expression

# make tab completion not bad
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

# # dotnet suggest shell start
# if (Get-Command "dotnet-suggest" -errorAction SilentlyContinue)
# {
#     $availableToComplete = (dotnet-suggest list) | Out-String
#     $availableToCompleteArray = $availableToComplete.Split([Environment]::NewLine, [System.StringSplitOptions]::RemoveEmptyEntries)

#     Register-ArgumentCompleter -Native -CommandName $availableToCompleteArray -ScriptBlock {
#         param($wordToComplete, $commandAst, $cursorPosition)
#         $fullpath = (Get-Command $commandAst.CommandElements[0]).Source

#         $arguments = $commandAst.Extent.ToString().Replace('"', '\"')
#         dotnet-suggest get -e $fullpath --position $cursorPosition -- "$arguments" | ForEach-Object {
#             [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
#         }
#     }
# }
# else
# {
#     "Unable to provide System.CommandLine tab completion support unless the [dotnet-suggest] tool is first installed."
#     "See the following for tool installation: https://www.nuget.org/packages/dotnet-suggest"
# }

# $env:DOTNET_SUGGEST_SCRIPT_VERSION = "1.0.2"
# # dotnet suggest script end
