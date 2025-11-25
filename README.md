# Apple MacBook Development Environment Setup

Complete automation scripts to set up a fresh MacBook with development tools and productivity applications.

## Quick Start

### 1. Initial Setup (Required)

```bash
# Download the setup script
curl -O https://raw.githubusercontent.com/wmar-dev/macbook/main/setup.sh

# Make it executable
chmod +x setup.sh

# Run the setup
bash setup.sh
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
~/Developer/
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
cd ~/Developer/projects
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

## Battery Life Optimization

These settings and practices will help maximize your MacBook's battery life during development work:

### System Settings

**Display & Brightness**
```bash
# Reduce screen brightness (use keyboard: F1/F2 or adjust in System Settings)
# Enable auto-brightness: System Settings > Display > Automatically adjust brightness
# Reduce display sleep time: System Settings > Lock Screen > Turn display off after 2-5 minutes
```

**Energy Saver Settings**
- Navigate to **System Settings > Battery**
- Enable "Low power mode" when on battery
- Enable "Optimize video streaming while on battery"
- Turn off "Wake for network access" when on battery

**Reduce Background Activity**
```bash
# Disable Spotlight indexing for specific folders
sudo mdutil -i off /path/to/folder

# Check battery-draining processes
top -o power

# Check energy impact by app
Activity Monitor > Energy tab > Sort by "Energy Impact"
```

### Development-Specific Optimizations

**Docker**
```bash
# Quit Docker when not actively using it
# In Docker Desktop: Preferences > Resources > Reduce CPUs and Memory allocation
# Set CPUs to 2-4 and Memory to 4-6GB instead of defaults

# Stop unused containers
docker stop $(docker ps -q)
```

**Node.js & Development Servers**
```bash
# Stop dev servers when not actively developing
# Use nodemon with polling disabled for file watching
nodemon --no-stdin --legacy-watch false

# For webpack dev server, reduce resource usage
# In webpack.config.js:
# devServer: { watchOptions: { poll: false } }
```

**VS Code**
```json
// Add to settings.json (Cmd+, then click icon in top-right)
{
  "files.watcherExclude": {
    "**/.git/objects/**": true,
    "**/node_modules/**": true,
    "**/dist/**": true,
    "**/build/**": true
  },
  "search.followSymlinks": false,
  "extensions.autoUpdate": false,  // Update manually
  "extensions.autoCheckUpdates": false
}
```

### Best Practices

1. **Close Unused Applications**: Quit apps completely (Cmd+Q) instead of minimizing
2. **Limit Browser Tabs**: Each tab consumes CPU and memory
3. **Disable Bluetooth/Wi-Fi**: Turn off when not needed
4. **Use Safari**: More energy-efficient than Chrome for browsing
5. **Avoid Video Calls**: Use audio-only when possible (Zoom, Slack)
6. **Keep macOS Updated**: Updates often include battery optimizations
7. **Manage Menu Bar Apps**: Quit background apps running in menu bar
8. **Disable File Syncing**: Pause Dropbox, OneDrive, Google Drive when on battery
9. **Use Dark Mode**: Slightly reduces power on OLED screens (recent MacBook Pros)

### Quick Battery Check

```bash
# Check battery status
pmset -g batt

# Check battery health
system_profiler SPPowerDataType | grep -A 5 "Health Information"

# See what's preventing sleep
pmset -g assertions

# Check power-hungry processes
sudo powermetrics --samplers tasks --show-process-energy -n 1
```

### Battery Maintenance

- **Optimal Charge Range**: Keep battery between 20-80% for longevity
- **Enable Optimized Battery Charging**: System Settings > Battery > Battery Health > Optimized Battery Charging
- **Calibrate Occasionally**: Once every 2-3 months, fully discharge then fully charge
- **Avoid Extreme Temperatures**: Keep MacBook in 50-95°F (10-35°C) environments

# Close everything except essential apps
# Reduce brightness to minimum
# Enable Low Power Mode: System Settings > Battery
# Disable Wi-Fi and Bluetooth
# Quit Docker, VS Code, and all dev servers
# Use Terminal instead of GUI apps when possible
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
    - `sudo mkdir -p /usr/local/bin && sudo ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl`
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
