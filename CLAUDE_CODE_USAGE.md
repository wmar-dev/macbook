# Using Claude Code

This setup installs the `claude` desktop app (via Homebrew Cask in [setup.sh](setup.sh)). This guide covers the Claude Code CLI itself — the terminal-based agentic coding tool — which is installed separately.

## Install

```bash
npm install -g @anthropic-ai/claude-code
```

Requires Node.js (already installed by [setup.sh](setup.sh) via nvm).

## Getting Started

Run `claude` from inside any project directory:

```bash
cd ~/Developer/projects/your-project
claude
```

On first run you'll be prompted to log in with your Anthropic account (or configure an API key).

## Common Usage

- **Start a session**: `claude` — opens an interactive session in the current directory
- **One-off prompt**: `claude "explain what this function does"`
- **Resume last session**: `claude --continue` (or `--resume` to pick from a list)
- **Print mode (non-interactive)**: `claude -p "summarize recent changes"`

## Useful Slash Commands

Inside a session:

- `/help` — list available commands
- `/clear` — clear the conversation and start fresh
- `/init` — generate a `CLAUDE.md` for the current repo (project-specific guidance for Claude)
- `/config` — adjust settings like model or theme
- `/permissions` — review or edit tool permission rules

## Project Configuration

Claude Code reads a `CLAUDE.md` file (like [CLAUDE.md](CLAUDE.md) in this repo) at the project root for repo-specific context: architecture notes, conventions, and common commands. Keep it updated as the project evolves so Claude can work with accurate context.

## Tips

- Ask Claude to make a plan before large changes — it can propose a plan for review before editing files.
- Use `git` normally alongside Claude; it will stage, diff, and commit when asked, but won't push or force-push without confirmation.
- For permission prompts on repeated safe commands (e.g. `npm test`), add allowlist rules in `.claude/settings.json` rather than approving every time.

## Environment Variables

A few environment variables worth knowing:

- `CLAUDE_CODE_MAX_WEB_SEARCHES_PER_SESSION` — caps the number of WebSearch calls per session (default: 200). Once the cap is reached, further WebSearch calls return a notice telling Claude to continue with the information already gathered. Accepts a positive whole number with no upper bound (so you can raise it, but not disable it). Requires Claude Code v2.1.212 or later.
- `CLAUDE_CODE_DISABLE_WEB_FETCH` — set to `1` to turn off the WebFetch tool (WebSearch stays available).

## More Info

Full documentation: https://docs.claude.com/claude-code
