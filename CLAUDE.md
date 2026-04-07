# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This is a macOS development environment automation repository that transforms a fresh MacBook into a fully-configured development machine. It consists of two main Bash scripts that handle installation and configuration of development tools, languages, and applications.

## Main Scripts

### setup.sh
Primary installation script that runs first. Handles base system setup including:
- Xcode Command Line Tools, Homebrew, Git, Ruby, Node.js (via nvm v24)
- Development tools via Homebrew (db-browser-for-sqlite, deno, ffmpeg, gemini-cli, gh, graphviz, openscad)
- Applications via Homebrew Cask (basictex, claude)

**Execute**: `bash setup.sh`

**Key characteristics**:
- Idempotent (safe to run multiple times)
- Checks existing installations before installing
- Auto-configures Homebrew PATH for both Apple Silicon (M1/M2) and Intel Macs
- Creates ~/Developer directory structure
- Uses color-coded output functions (print_success, print_warning, print_error)

### dev-environment-setup.sh
Optional menu-driven script for specialized development environment configuration. Provides interactive options for:
1. Node.js (yarn, pnpm, TypeScript, frameworks)
2. Python (uv package manager, virtual environment at ~/.venv, common packages)
3. Ruby (rbenv, Bundler)
4. Git (aliases, global .gitignore)
5. Docker (compose templates)
6. VS Code extensions
7. Shell configuration (zsh aliases)

**Execute**: `bash dev-environment-setup.sh`

## Architecture Patterns

**Script Design**:
- Modular function-based design with helper functions for colored output
- Error handling via `set -e` (exit on error)
- Pre-installation checks to prevent duplicate installs
- Bash arrays for bulk installations with loop-based processing
- HEREDOC for multi-line file generation (templates, configs)
- Environment variable sourcing after installations

**Directory Structure Created**:
```
~/Developer/
├── projects/          # User project files
├── learning/          # Learning resources
├── scripts/           # Utility scripts
├── python-template/   # Python project starter (created by dev-environment-setup.sh)
└── docker-template/   # Docker compose template (created by dev-environment-setup.sh)
```

## Common Modifications

When adding new tools or applications to the setup:

**To add Homebrew packages** (edit setup.sh):
```bash
# Add to the brew_packages array around line 70
brew_packages=(
  "existing-package"
  "new-package"  # Add here
)
```

**To add Homebrew Cask applications** (edit setup.sh):
```bash
# Add to the cask_apps array around line 85
cask_apps=(
  "existing-app"
  "new-app"  # Add here
)
```

**To modify Python packages** (edit dev-environment-setup.sh):
Look for the `configure_python()` function and modify the uv pip install command.

**To add Git aliases** (edit dev-environment-setup.sh):
Look for the `configure_git()` function and add to the git config commands.

## Important Notes

- Both scripts are designed to be idempotent - they check for existing installations and skip if already present
- The repository is in active development with frequent small commits adding tools incrementally
- Current uncommitted changes in setup.sh add db-browser-for-sqlite, openscad, and claude
- Scripts support both ARM64 (Apple Silicon) and x86_64 (Intel) architectures
- Installation time varies from 20-45 minutes depending on internet speed
- Some installations may require sudo password

## Testing Changes

Since these are installation scripts that modify the system:
- Test changes in a VM or fresh macOS environment when possible
- For minor additions, verify the package/app name exists in Homebrew first: `brew search <package-name>`
- Run with bash explicitly: `bash script.sh` (do not use sh, which may not support bash features)
- Check script syntax before committing: `bash -n setup.sh`

## README.md

The README.md contains extensive documentation including:
- Complete installation instructions
- Post-installation steps (SSH keys, Git config)
- Battery life optimization guide (display settings, Docker resource limits, VS Code file watcher exclusions)
- Troubleshooting common issues (permissions, PATH problems, Docker startup)
- Manual application installation links for tools not in scripts (GIMP, JabRef, MacTeX, etc.)

Always keep README.md updated when adding new tools to the setup scripts.
