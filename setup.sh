#!/usr/bin/env bash

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
print_header() {
    echo -e "\n${BLUE}========================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}========================================${NC}\n"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    print_error "This script is designed for macOS only"
    exit 1
fi

print_header "MacBook Development Setup"
echo "This script will:"
echo "  • Install Xcode Command Line Tools"
echo "  • Install and configure Homebrew"
echo "  • Install development tools and languages"
echo "  • Install common applications"
echo ""
read -p "Continue? (y/n) " -n 1 -r; echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Setup cancelled"
    exit 1
fi

# 1. Install Xcode Command Line Tools
print_header "Installing Xcode Command Line Tools"
if ! command -v xcode-select &> /dev/null; then
    xcode-select --install
    print_success "Xcode Command Line Tools installed"
else
    print_success "Xcode Command Line Tools already installed"
fi

# 2. Install Homebrew
print_header "Installing Homebrew"
if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH
    if [[ $(uname -m) == "arm64" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    else
        eval "$(/usr/local/bin/brew shellenv)"
        echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zprofile
    fi
    
    print_success "Homebrew installed and configured"
else
    print_success "Homebrew already installed"
fi

# 3. Update Homebrew
print_header "Updating Homebrew"
brew update
print_success "Homebrew updated"

# 4. Install Development Tools
print_header "Installing Development Tools"

# Git
if ! command -v git &> /dev/null; then
    brew install git
    print_success "Git installed"
else
    print_success "Git already installed"
fi

# Ruby
print_header "Installing Ruby"
if ! command -v ruby &> /dev/null; then
    brew install ruby
    print_success "Ruby installed"
else
    print_success "Ruby already installed"
fi

# Node.js and npm (using nvm)
print_header "Installing Node.js/npm (using nvm)"
if [ ! -d "$HOME/.nvm" ]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    nvm install 24
    print_success "Node.js and npm installed via nvm"
else
    print_success "nvm already installed"
fi

# 5. Install Code Editors and IDEs
print_header "Installing Code Editors and IDEs"

# 6. Install Productivity Tools
print_header "Installing Productivity Tools"

tools=(
)

for tool in "${tools[@]}"; do
    if ! brew list "$tool" &> /dev/null; then
        brew install "$tool"
        print_success "$tool installed"
    else
        print_success "$tool already installed"
    fi
done

# 7. Install Applications (via Homebrew Cask)
print_header "Installing Common Applications"

applications=(
)

for app in "${applications[@]}"; do
    if ! brew list --cask "$app" &> /dev/null; then
        brew install --cask "$app"
        print_success "$app installed"
    else
        print_success "$app already installed"
    fi
done

# 8. Configure Shell
print_header "Configuring Shell"

# Check if using zsh (default on macOS Catalina+)
if [ -z "$SHELL" ] || [[ "$SHELL" != *"zsh"* ]]; then
    chsh -s /bin/zsh
    print_success "Shell changed to zsh"
else
    print_success "Already using zsh"
fi

# 9. Create development directories
print_header "Creating Development Directory"

mkdir -p ~/Developer

print_success "Development directory created in ~/Developer/"

# 10. Final cleanup and summary
print_header "Setup Complete!"
brew cleanup
print_success "Homebrew cache cleaned"

echo -e "\n${GREEN}Your MacBook is now set up!${NC}\n"
echo "Next steps:"
echo "  1. Launch Docker from Applications and complete its setup"
echo "  2. Configure SSH keys: ssh-keygen -t ed25519 -C 'your_email@example.com'"
echo "  3. Configure your shell (zsh) by editing ~/.zshrc"
echo "  4. Install additional tools as needed with: brew install <package>"
echo ""
echo "Useful commands:"
echo "  • brew search <package>  - Search for packages"
echo "  • brew install <package> - Install a package"
echo "  • brew upgrade           - Upgrade all packages"
echo "  • brew list              - List installed packages"
echo ""
print_success "Setup script finished!"