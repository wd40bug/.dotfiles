oh-my-posh init pwsh --config $HOME/.dotfiles/.mytheme.toml | Invoke-Expression
function Set-EnvVar {
    $env:COLS=$(&{$H=get-host;$H.ui.rawui.WindowSize.Width;})
}
New-Alias -Name 'Set-PoshContext' -Value 'Set-EnvVar' -Scope Global -Force
New-Alias -Name 'nvide' -Value 'neovide' -Scope Global -Force
Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1
