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
  - Agent rules: `~/.agents/AGENTS.local.md` (appended by `.chezmoitemplates/AGENTS.md.tmpl`)
  - mise tools: `~/.config/mise/conf.d/*.toml`
- Ensure all repository-level docs, swap files, temporary files, and the local files above remain listed in `.chezmoiignore.tmpl`.
- Never bypass the pre-commit hook with `--no-verify`.

### 4. Search & Command Execution
- Always use `rg` (ripgrep) instead of `grep`.
- Always use `fd` instead of `find`.

### 5. Agent Configuration
- `.chezmoitemplates/AGENTS.md.tmpl` is the one source for the global agent rules.
  `dot_claude/CLAUDE.md.tmpl` and `private_dot_codex/AGENTS.md.tmpl` render it.
- Skills live in `dot_agents/skills/<name>/SKILL.md`.
  Each `dot_claude/private_skills/<name>/SKILL.md.tmpl` includes the matching file.
- Never use the `exact_` prefix on a skills directory.
  Other tools install their own skills there.

### 6. Templates
- Give each template file the `.tmpl` suffix, including each file in `.chezmoitemplates/` and `.chezmoiignore.tmpl`.
  chezmoi 2.73.0 reads `.chezmoiignore.tmpl`, and `.chezmoiversion` stops an older chezmoi, which would skip the file without a warning.
- Do not add `.tmpl` to a file that only shows template syntax as an example, for example `dot_gemini/config/skills/chezmoi-dotfiles/SKILL.md`.
  chezmoi would run the example and fail.
