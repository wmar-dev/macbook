#!/bin/bash

# Advanced Development Environment Configuration
# Run this after the main setup script to configure specific development environments
# Usage: bash dev-environment-setup.sh

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

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

# Setup Node.js development
setup_nodejs() {
    print_header "Configuring Node.js Development Environment"
    
    # Install global npm packages
    npm install -g \
        yarn \
        pnpm \
        typescript \
        ts-node \
        nodemon \
        eslint \
        prettier \
        create-react-app \
        @angular/cli \
        @nestjs/cli
    
    print_success "Node.js global packages installed"
}

# Setup Python development
setup_python() {
    print_header "Configuring Python Development Environment"
    
    # Install uv
    curl -LsSf https://astral.sh/uv/install.sh | sh
    uv self update

    # Create virtual environment template
    python3 -m pip install --upgrade pip setuptools wheel
    
    # Install common Python packages
    python3 -m pip install \
        virtualenv \
        pipenv \
        poetry \
        black \
        flake8 \
        pylint \
        pytest \
        requests \
        numpy \
        pandas \
        django \
        flask
    
    print_success "Python packages installed"
    
    # Create a Python project template
    mkdir -p ~/Developer/python-template
    cat > ~/Developer/python-template/requirements.txt << 'EOF'
# Add your project dependencies here
requests>=2.28.0
python-dotenv>=0.20.0
EOF
    
    print_success "Python project template created at ~/Developer/python-template"
}

# Setup Ruby development
setup_ruby() {
    print_header "Configuring Ruby Development Environment"
    
    # Install rbenv for Ruby version management
    if ! command -v rbenv &> /dev/null; then
        brew install rbenv ruby-build
        rbenv init
        echo 'eval "$(rbenv init - zsh)"' >> ~/.zshrc
        print_success "rbenv installed"
    fi
    
    # Install Bundler
    gem install bundler
    print_success "Ruby Bundler installed"
}

# Setup Git configuration
setup_git() {
    print_header "Configuring Git"
    
    # Set useful git aliases
    git config --global alias.st status
    git config --global alias.co checkout
    git config --global alias.br branch
    git config --global alias.cm commit
    git config --global alias.unstage 'reset HEAD --'
    git config --global alias.last 'log -1 HEAD'
    git config --global alias.visual 'log --graph --oneline --all'
    
    # Configure git editor
    git config --global core.editor "nano"
    
    # Setup .gitignore
    cat > ~/.gitignore_global << 'EOF'
# Compiled files
*.o
*.so
*.pyc
*.pyo
*.class

# Virtual environments
venv/
ENV/
env/
node_modules/

# IDE
.vscode/
.idea/
*.swp
*.swo
*~
.DS_Store

# Environment variables
.env
.env.local

# Logs
*.log
EOF
    
    git config --global core.excludesfile ~/.gitignore_global
    print_success "Git configured with useful aliases and global gitignore"
}

# Setup Docker development
setup_docker() {
    print_header "Configuring Docker"
    
    # Create docker-compose template
    mkdir -p ~/Developer/docker-template
    cat > ~/Developer/docker-template/docker-compose.yml << 'EOF'
version: '3.8'

services:
  app:
    build: .
    ports:
      - "3000:3000"
    volumes:
      - .:/app
    environment:
      - NODE_ENV=development
EOF
    
    print_success "Docker template created at ~/Developer/docker-template"
}

# Setup VSCode extensions
setup_vscode() {
    print_header "Installing VS Code Extensions"
    
    extensions=(
        "esbenp.prettier-vscode"
        "dbaeumer.vscode-eslint"
        "ms-python.python"
        "ms-python.vscode-pylance"
        "rebornix.ruby"
        "ms-docker.docker"
        "gitpod.workspace-full"
        "eamodio.gitlens"
        "ms-vscode.remote-repositories"
    )
    
    for ext in "${extensions[@]}"; do
        code --install-extension "$ext" 2>/dev/null || print_warning "Could not install $ext (VS Code may not be in PATH)"
    done
    
    print_success "VS Code extensions installed (if VS Code is available)"
}

# Setup shell configuration
setup_shell() {
    print_header "Optimizing Shell Configuration"
    
    # Backup existing zshrc
    if [ -f ~/.zshrc ]; then
        cp ~/.zshrc ~/.zshrc.backup
    fi
    
    # Add useful aliases and functions
    cat >> ~/.zshrc << 'EOF'

# ========================================
# Development Environment Aliases
# ========================================

# Navigation
alias dev='cd ~/Developer'
alias projects='cd ~/Developer/projects'
alias ll='ls -lah'
alias ..='cd ..'
alias ...='cd ../..'

# Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline -10'

# Development
alias python='python3'
alias activate='source venv/bin/activate'
alias deactivate='deactivate'

# Node
alias ni='npm install'
alias nr='npm run'
alias nd='npm run dev'

# Docker
alias dc='docker-compose'
alias dcup='docker-compose up -d'
alias dcdown='docker-compose down'

# Utilities
alias weather='curl wttr.in'
alias myip='curl ifconfig.me'

EOF
    
    source ~/.zshrc
    print_success "Shell configuration updated"
}

# Main menu
print_header "Advanced Development Environment Setup"

echo "Select configurations to install:"
echo "1) Node.js development"
echo "2) Python development"
echo "3) Ruby development"
echo "4) Git configuration"
echo "5) Docker setup"
echo "6) VS Code extensions"
echo "7) Shell configuration"
echo "8) All of the above"
echo "0) Skip all"
echo ""

read -p "Enter your choices (comma-separated, e.g., 1,2,3): " choices

if [[ "$choices" == "8" ]]; then
    setup_nodejs
    setup_python
    setup_ruby
    setup_git
    setup_docker
    setup_vscode
    setup_shell
elif [[ "$choices" == "0" ]]; then
    print_warning "Setup skipped"
    exit 0
else
    IFS=',' read -ra CHOICE_ARRAY <<< "$choices"
    for choice in "${CHOICE_ARRAY[@]}"; do
        case $choice in
            1) setup_nodejs ;;
            2) setup_python ;;
            3) setup_ruby ;;
            4) setup_git ;;
            5) setup_docker ;;
            6) setup_vscode ;;
            7) setup_shell ;;
            *) print_warning "Unknown option: $choice" ;;
        esac
    done
fi

print_header "Configuration Complete!"
echo "Your development environment is now configured!"
