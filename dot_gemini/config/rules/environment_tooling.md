# Local Machine Environment & Tooling Conventions

## Toolchain & Runtime Management
- This machine uses **mise** (`~/.local/bin/mise`) for all language runtimes (Node, Python, Go, Rust, etc.) and developer CLI utilities.
- Do NOT invoke or rely on `nvm`, `pyenv`, or `chruby` (they have been retired and removed).
- To install or manage tools and runtimes, use `mise use <tool>@<version>` or `mise install`.
- When running project tasks, always check for a `mise.toml` or `Taskfile` first and prefer `mise run <task>`.

## Search & Discovery Tools
- Use **`rg`** (`ripgrep`) instead of `grep` for file content searches. It is significantly faster, respects `.gitignore`, and prevents excessive token consumption.
- Use **`fd`** instead of `find` for file and directory searches.

## Package Management & Binaries
- Do NOT execute `brew install` for toolchains or developer utilities on this machine; Homebrew lacks prebuilt bottles for macOS on Intel x86_64 and will attempt to compile from source (LLVM/Rust cascades).
- Prefer precompiled standalone binaries via `mise use -g <tool>` or official standalone installers into `~/.local/bin`.

## Git & Diffs
- Git pager is powered by **`delta`**.
