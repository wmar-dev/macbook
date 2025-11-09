# Apple MacBook Development Environment Setup

Complete automation scripts to set up a fresh MacBook with development tools and productivity applications.

## Quick Start

### 1. Initial Setup (Required)

```bash
curl -o- https://raw.githubusercontent.com/wmar-dev/macbook/main/setup.sh | bash
```

The initial setup script will:
- ✓ Install Xcode Command Line Tools
- ✓ Install and configure Homebrew
- ✓ Install Git, Node.js, Python, Ruby
- ✓ Install Docker
- ✓ Install VS Code
- ✓ Install common productivity apps (Slack, Notion, Zoom, Spotify, VLC)
- ✓ Configure your shell (zsh)
- ✓ Create development directories

### 2. Development Environment Setup (Optional)

After the initial setup, configure specific development environments:

```bash
chmod +x dev-environment-setup.sh
bash dev-environment-setup.sh
```

Choose which environments to set up:
- Node.js (npm, yarn, pnpm, TypeScript, ESLint, Prettier)
- Python (virtualenv, Poetry, Flask, Django, pytest, numpy, pandas)
- Ruby (rbenv, Bundler)
- Git (aliases, global gitignore, configuration)
- Docker (compose templates)
- VS Code extensions
- Shell optimization (aliases and functions)

## What Gets Installed

### Package Managers
- **Homebrew** - macOS package manager
- **nvm** - Node version manager
- **rbenv** - Ruby version manager
- **pip** - Python package manager

### Development Tools
- **Git** - Version control
- **Node.js & npm** - JavaScript runtime and package manager
- **Python 3** - Python runtime
- **Ruby** - Ruby runtime
- **Docker** - Container platform

### Editors & IDEs
- **VS Code** - Code editor with extensions

### CLI Tools
- curl, wget, vim, htop, tree, jq, zsh-completions

### Applications
- Slack, Notion, Figma, Zoom, Spotify, VLC

## Directory Structure Created

```
~/dev/
├── projects/        # Your project files
├── learning/        # Learning resources and practice
├── scripts/         # Utility scripts
├── python-template/ # Python project template
└── docker-template/ # Docker compose template
```

## Post-Installation Steps

### 1. SSH Key Setup

Generate SSH keys for GitHub/GitLab:

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
cat ~/.ssh/id_ed25519.pub  # Copy this to GitHub
```

### 2. Configure VS Code

- Install extensions manually: Extensions marketplace in VS Code
- Or use the dev-environment-setup.sh script (option 6)

### 3. Create First Project

```bash
cd ~/dev/projects
mkdir my-project
cd my-project

# For Node.js
npm init -y

# For Python
python3 -m venv venv
source venv/bin/activate
```

### 4. Git Configuration

If not already done during setup:

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

## Common Commands

### Homebrew
```bash
brew install <package>      # Install a package
brew upgrade                # Upgrade all packages
brew list                   # List installed packages
brew search <package>       # Search for a package
brew uninstall <package>    # Remove a package
brew cleanup                # Clean up cache
```

### Node.js (nvm)
```bash
nvm install node            # Install latest Node.js
nvm use node                # Switch to Node.js
nvm list                    # List installed versions
npm install -g <package>    # Install global npm package
```

### Python
```bash
python3 --version           # Check Python version
python3 -m venv venv        # Create virtual environment
source venv/bin/activate    # Activate virtual environment
pip install <package>       # Install Python package
```

### Docker
```bash
docker --version            # Check Docker version
docker run hello-world      # Test Docker installation
docker ps                   # List running containers
docker-compose up           # Start services
docker-compose down         # Stop services
```

### Git
```bash
git status                  # Check status
git add .                   # Stage changes
git commit -m "message"     # Commit changes
git push                    # Push to remote
git log --oneline           # View commit history
git branch -a               # List all branches
```

## Customization

### Add More Homebrew Packages

Edit `setup.sh` and add packages to the relevant sections:

```bash
# Add to the tools array:
tools=(
    "your-package"
    "another-package"
)

# Or install manually:
brew install your-package
```

### Add More Applications

Edit the `applications` array in `setup.sh`:

```bash
applications=(
    "slack"
    "your-app"
)
```

### Modify Global Aliases

Edit `dev-environment-setup.sh` in the `setup_shell()` function to add custom aliases.

## Troubleshooting

### Script won't execute
```bash
chmod +x setup.sh
bash setup.sh
```

### Homebrew permission issues
```bash
# Fix Homebrew permissions
sudo chown -R $(whoami) /usr/local/Cellar
```

### Node.js/npm not found after setup
```bash
# Reload shell configuration
source ~/.zshrc

# Or open a new terminal window
```

### Docker won't start
1. Launch Docker from Applications
2. Complete Docker setup wizard
3. Verify: `docker run hello-world`

### VS Code extensions won't install
- Ensure VS Code is installed and in your PATH
- Install extensions manually through VS Code marketplace

## What's Not Included

This setup focuses on general development. You may want to add:
- **Language-specific tools**: Go, Rust, PHP, Java, etc.
- **Databases**: PostgreSQL, MySQL, MongoDB
- **Cloud tools**: AWS CLI, Google Cloud SDK, Terraform
- **Additional editors**: JetBrains IDEs, Sublime Text, Neovim
- **Specialized tools**: MATLAB, Jupyter, Android Studio

To add these, use:
```bash
brew install <package>
brew install --cask <application>
```

## Applications
- [Audacity](https://www.audacityteam.org/)
- [Blender](https://www.blender.org/)
- [Chrome](https://www.google.com/chrome/)
- [Docker Desktop](https://www.docker.com/)
- [Firefox](https://www.firefox.com/)
- [Fusion](https://www.autodesk.com/products/fusion-360/personal)
- [Gimp](https://www.gimp.org/)
- [LibreOffice](https://www.libreoffice.org/)
- [Raspberry Pi Imager](https://www.raspberrypi.com/software/)
- [OpenSCAD](https://openscad.org/)
- [Sublime Text](https://www.sublimetext.com/)
- [TexShop](https://pages.uoregon.edu/koch/texshop/)
- [Visual Studio Code](https://code.visualstudio.com/)
- [VLC](https://www.videolan.org/vlc/)

## Support & Resources

- **Homebrew**: https://brew.sh
- **Node.js/nvm**: https://github.com/nvm-sh/nvm
- **Python**: https://www.python.org
- **Ruby/rbenv**: https://github.com/rbenv/rbenv
- **Docker**: https://www.docker.com
- **Git**: https://git-scm.com

## License

These scripts are provided as-is for personal and educational use.

## Notes

- The scripts are idempotent: running them multiple times is safe
- Backup important data before running setup scripts
- Some installations may require entering your password
- Installation time depends on internet speed (usually 20-45 minutes)
