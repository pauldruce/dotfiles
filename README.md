# Paul Druce's Dotfiles

Modern, minimal, and fast developer configuration managed with [chezmoi](https://www.chezmoi.io/) and [mise](https://mise.jdx.dev/).

Supports **macOS**, **Linux** (including Raspberry Pi), and **Windows** (WSL2 & Native PowerShell).

---

## What's Included

* **Shells**:
  * **Zsh** (macOS & Linux): Native Zsh with fast completions and history optimization
  * **PowerShell** (Windows & cross-platform): `mise`, `starship`, `zoxide`, and modern CLI alias wrappers
* **Prompt**: [Starship](https://starship.rs/) (2-line minimal prompt with rich Git indicators)
* **Terminal**: [Ghostty](https://ghostty.org/) (macOS & Linux) / Windows Terminal
* **Version & Tool Manager**: [mise](https://mise.jdx.dev/) (`~/.config/mise/config.toml`)
* **Modern CLI Suite**:
  * `eza` (modern `ls` with icons and git flags)
  * `bat` (syntax-highlighted `cat`)
  * `delta` (syntax-highlighted git diffs with `git sbs` side-by-side)
  * `lazygit` (`lg` terminal git UI)
  * `dust` (visual disk analyzer)
  * `k9s` (Kubernetes TUI)
  * `jless` (interactive JSON viewer)
  * `btm` (`bottom` system resource monitor)
  * `mosh` (mobile shell for remote servers)
  * `fzf` & `zoxide` (fuzzy finder & smart directory jumping)
* **AI Agent Configurations**:
  * `~/.agents/AGENTS.md` (Universal guidelines for AI coding agents)
  * `~/.claude/CLAUDE.md` (Claude Code configuration)
  * `~/.gemini/config/` (Antigravity global environment rule & chezmoi management skill)

---

## Bootstrapping a New Machine

### macOS & Linux (Native or WSL)

```bash
# 1. Install chezmoi and apply dotfiles:
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply https://github.com/pauldruce/dotfiles

# 2. Install all CLI tools declared in mise/config.toml:
curl https://mise.run | sh
mise install
```

### Windows (PowerShell)

```powershell
# 1. Allow local script execution (run once):
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# 2. Install chezmoi and apply dotfiles:
irm https://get.chezmoi.io/ps1 | iex
chezmoi init --apply https://github.com/pauldruce/dotfiles

# 3. Install mise tools:
irm https://mise.jdx.dev/install.ps1 | iex
mise install
```

---

## Machine-Specific Customization

* **Zsh local settings**: Store employer-specific proxies, private hostnames, or tokens in `~/.zshrc.local` (automatically sourced, never tracked in Git).
* **Git local settings**: Override your git email or signing keys per-machine in `~/.gitconfig.local`.

---

## Daily Workflow

* **Edit a config file**:
  ```bash
  chezmoi edit ~/.zshrc
  ```
* **See pending changes between repo and your machine**:
  ```bash
  chezmoi diff
  ```
* **Apply changes**:
  ```bash
  chezmoi apply
  ```
* **Commit and push updates to GitHub**:
  ```bash
  chezmoi cd
  git add .
  git commit -m "Update configs"
  git push
  ```
