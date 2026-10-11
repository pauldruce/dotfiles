# Dot-source the cross-platform profile from ~/.config/powershell/profile.ps1
$sharedProfile = Join-Path $HOME ".config/powershell/profile.ps1"
if (Test-Path $sharedProfile) {
    . $sharedProfile
}
