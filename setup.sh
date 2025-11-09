#!/bin/bash

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

# 1. Install Xcode Command Line Tools
print_header "Installing Xcode Command Line Tools"
if ! command -v xcode-select &> /dev/null; then
    xcode-select --install
    print_success "Xcode Command Line Tools installed"
else
    print_success "Xcode Command Line Tools already installed"
fi
