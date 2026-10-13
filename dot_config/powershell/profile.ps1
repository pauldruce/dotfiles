# =============================================================================
# Cross-Platform PowerShell Profile (mise + starship + modern cli tools)
# Managed by chezmoi
# =============================================================================

# 1. Mise Activation
if (Get-Command mise -ErrorAction SilentlyContinue) {
    if ($PSVersionTable.PSVersion.Major -lt 7) { $env:MISE_PWSH_CHPWD_WARNING = 0 }
    & mise activate powershell | Out-String | Invoke-Expression
}

# 2. Starship Prompt (must load before zoxide)
if (Get-Command starship -ErrorAction SilentlyContinue) {
    Invoke-Expression (&starship init powershell)
}

# 3. Zoxide Integration
if (Get-Command zoxide -ErrorAction SilentlyContinue) {
    Invoke-Expression (& { (zoxide init powershell | Out-String) })
}

# 4. Modern CLI Replacements
# eza -> ls / ll
if (Get-Command eza -ErrorAction SilentlyContinue) {
    Remove-Item Alias:ls -Force -ErrorAction SilentlyContinue
    function ls { eza --icons --group-directories-first @args }
    function ll { eza -la --icons --group-directories-first @args }
}

# bat -> cat
if (Get-Command bat -ErrorAction SilentlyContinue) {
    Remove-Item Alias:cat -Force -ErrorAction SilentlyContinue
    function cat { bat --paging=never @args }
}

# lazygit -> lg
if (Get-Command lazygit -ErrorAction SilentlyContinue) {
    Set-Alias -Name lg -Value lazygit
}
