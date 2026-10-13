# Paul Druce's Dotfiles

Modern, minimal, and fast developer configuration managed with [chezmoi](https://www.chezmoi.io/) and [mise](https://mise.jdx.dev/).

Supports **macOS**, **Linux** (including Raspberry Pi), and **Windows** (WSL2 & Native PowerShell).

---

## What's Included

* **Shells**:
  * **Zsh** (macOS & Linux): Native Zsh with fast completions and history optimization
    * `zsh-syntax-highlighting` (a command is green if it exists, red if not) and `zsh-autosuggestions`, downloaded to `~/.zsh/plugins/` by `.chezmoiexternal.toml.tmpl` and refreshed each week
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
  * `~/.claude/CLAUDE.md` and `~/.codex/AGENTS.md` (one set of global agent rules, from `.chezmoitemplates/AGENTS.md.tmpl`)
  * `~/.agents/skills/` and `~/.claude/skills/` (agent skills, from `dot_agents/skills/`)
  * `~/.gemini/config/` (Antigravity global environment rule & chezmoi management skill)

---

## Bootstrapping a New Machine

### macOS & Linux (Native or WSL)

```bash
# 1. Linux only: install zsh and make it your login shell:
sudo apt install zsh && chsh -s "$(command -v zsh)"

# 2. Install chezmoi and apply dotfiles:
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply https://github.com/pauldruce/dotfiles

# 3. Install all CLI tools declared in mise/config.toml, including starship:
curl https://mise.run | sh
~/.local/bin/mise install
```

Open a new terminal to get the starship prompt.

### Windows (PowerShell)

```powershell
# 1. Allow local script execution (run once):
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# 2. Install chezmoi and mise, then open a new terminal so they are on Path:
winget install twpayne.chezmoi
winget install jdx.mise

# 3. Apply dotfiles and install the CLI tools, including starship:
chezmoi init --apply https://github.com/pauldruce/dotfiles
mise install
```

Open a new terminal to get the starship prompt.
The prompt uses Nerd Font symbols, so set a Nerd Font in Windows Terminal, for example CaskaydiaCove Nerd Font.

---

## Machine-Specific Customization

Each machine adds its own layer from local files.
chezmoi ignores these files, so they never enter this repo.

| Local file | Use it for | How it loads |
|---|---|---|
| `~/.zshrc.local` | Proxies, private hostnames, tokens, and work shell config | `~/.zshrc` sources it at the end |
| `~/.gitconfig.local` | A work email or signing key | `~/.gitconfig` includes it |
| `~/.agents/AGENTS.local.md` | Work agent rules | `chezmoi apply` appends it to `~/.claude/CLAUDE.md` and `~/.codex/AGENTS.md` |
| `~/.config/mise/conf.d/*.toml` | Work tools | mise merges it with `~/.config/mise/config.toml` |

* Put a work email under `[includeIf "gitdir:~/work/"]` in `~/.gitconfig.local`.
  A plain `user.email` there also applies to commits in this public repo.
* Add a work tool with `mise use --path ~/.config/mise/conf.d/work.toml <tool>`.
  `mise use -g` writes to the tracked `config.toml`.
* Run `chezmoi apply` after you edit `~/.agents/AGENTS.local.md`.

### Leak checks

Run these commands once in each clone of this repo:

```bash
chezmoi cd
git config user.email 30435358+pauldruce@users.noreply.github.com
mise trust && mise install && mise run setup
```

The pre-commit hook then blocks a commit when:

* the author email is not the noreply address,
* a staged line matches a pattern in `~/.config/dotfiles/denylist`, or
* `trivy` finds a secret.

The denylist holds one case-insensitive regex per line, for example an employer name or an internal hostname.
Keep it local, because the patterns themselves are private.
`trivy` skips paths that look like tests, and the denylist check does not.

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
