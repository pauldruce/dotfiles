---
name: chezmoi-dotfiles
description: >-
  Use this skill when modifying, inspecting, or troubleshooting shell configuration,
  terminal settings, or dotfiles managed by chezmoi. Ensures safe editing of
  templates, diff previewing, and cross-platform synchronization.
---

# Chezmoi Dotfiles Management Skill

This runbook guides agents on how to safely inspect, edit, and apply dotfiles across macOS, Linux, and Windows using `chezmoi`.

## Core Rules

1. **Source of Truth**: The git repository is located at `~/.local/share/chezmoi`. Never edit `$HOME` files directly without recording them in the chezmoi repository.
2. **Template Awareness**: Files ending in `.tmpl` (e.g. `dot_zshrc.tmpl`) are Go templates. Always preserve platform conditionals (`{{ if eq .chezmoi.os "darwin" }}`).
3. **Safety First**: Always run `chezmoi diff` before applying changes.
4. **Secrets Isolation**: Never commit API keys, private tokens, or internal hostnames. Put machine-specific settings in `~/.zshrc.local` or `~/.gitconfig.local`.

---

## Standard Workflows

### 1. Modifying an Existing Config
To update a configuration:
```bash
# Option A: Edit via chezmoi CLI
chezmoi edit ~/.zshrc

# Option B: Edit the source file directly in the repo
# Edit ~/.local/share/chezmoi/dot_zshrc.tmpl

# 2. Preview the diff against your real machine
chezmoi diff

# 3. Apply the changes to $HOME
chezmoi apply
```

### 2. Adding a New CLI Tool to the Dotfiles Manifest
When installing a new persistent developer tool:
```bash
# 1. Install tool globally via mise
mise use -g <tool>@<version>

# 2. Update chezmoi's copy of the mise manifest
chezmoi re-add ~/.config/mise/config.toml

# 3. Verify status
chezmoi status
```

### 3. Tracking a New File in Dotfiles
```bash
# Add file to tracking
chezmoi add ~/.config/newapp/config

# Check git status in the chezmoi repo
chezmoi cd
git status
```

### 4. Committing and Pushing Updates
```bash
chezmoi cd
git add .
git commit -m "feat: description of changes"
git push
```
