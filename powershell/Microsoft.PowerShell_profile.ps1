Set-Alias -Name vim -Value nvim
Set-Alias -Name sudo -Value gsudo

$env:TERM = "xterm-256color"

if ($PSVersionTable.PSEdition -eq 'Core') {
    Remove-Alias -Name cat

    function cat {
        bat -pP @args
    }
}

Import-Module "gsudoModule"

# Check if the session is running as admin
$IsAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

function prompt {
    # ANSI escape sequences
    if ($PSVersionTable.PSEdition -eq 'Core') {
        $green = "`e[32m"
        $blue  = "`e[34m"
        $red   = "`e[31m"
        $yellow = "`e[33m"
        $reset = "`e[0m"
    }

    
    # User and host
    $user = $env:USERNAME
    $hostName = $env:COMPUTERNAME
    $pwd = (Get-Location).Path

    if ($pwd.StartsWith($home)) {
        $pwd = "~" + $pwd.Substring($home.Length)
    }

    $date = (Get-Date).ToString("HH:mm:ss,ff")

    $date = "$yellow[$date]$reset"

    # Compose prompt
    if ($IsAdmin) {
        return "$date $red$user$reset@$hostName $pwd # "
    } else {
        return "$date $green$user@$hostName$reset $blue$pwd$reset $ "
    }
}

Invoke-Expression (& { (zoxide init powershell | Out-String) })
