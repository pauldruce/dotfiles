# AGENTS.md — Dotfiles Repository Guidelines

This repository manages personal developer dotfiles across macOS, Linux (Raspberry Pi/Debian), and Windows using **chezmoi** and **mise**.

---

## Tooling & Architecture
- **Dotfiles Engine**: `chezmoi` manages templates and syncing to `$HOME`.
- **Runtimes & CLIs**: `mise` manages Node, Python, Go, Rust, and modern CLI binaries (`~/.config/mise/config.toml`).
- **Prompt**: `starship` (`dot_config/starship.toml`).
- **Terminal**: `ghostty` (`dot_config/ghostty/config`).
- **Shells**:
  - macOS & Linux: Zsh (`dot_zshrc.tmpl`)
  - Windows & Cross-platform: PowerShell (`dot_config/powershell/profile.ps1`)

---

## Agent Rules & Guidelines

### 1. Modifying Configurations
- **NEVER** edit destination files in `$HOME` (e.g. `~/.zshrc`) directly and assume they persist; always edit the source file in this repository (`~/.local/share/chezmoi`).
- For templates (`.tmpl`), maintain cross-platform conditionals (`{{ if eq .chezmoi.os "darwin" }}` vs `{{ else if eq .chezmoi.os "linux" }}`).
- **Always verify changes** with `chezmoi diff` before applying.
- Apply verified changes using `chezmoi apply`.

### 2. Adding New CLI Tools
- Install new command-line tools or language versions using `mise use -g <tool>@<version>`.
- After adding a tool in mise, run `chezmoi re-add ~/.config/mise/config.toml` so it is tracked in this repository.
- Do NOT use `brew install` for developer utilities or runtimes on this machine (to avoid source compilation).

### 3. Privacy & Secrets Boundaries
- **NEVER** commit API tokens, passwords, private SSH keys, internal IP addresses, or work hostnames.
- Keep machine-specific or private configurations in uncommitted local files:
  - Zsh: `~/.zshrc.local` (automatically sourced by `dot_zshrc.tmpl`)
  - Git: `~/.gitconfig.local` (automatically included by `dot_gitconfig`)
- Ensure all repository-level docs, swap files, and temporary files remain listed in `.chezmoiignore`.

### 4. Search & Command Execution
- Always use `rg` (ripgrep) instead of `grep`.
- Always use `fd` instead of `find`.
