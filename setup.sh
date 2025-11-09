#!/bin/bash

set -e  # Exit on any error

# 1. Install Xcode Command Line Tools
print_header "Installing Xcode Command Line Tools"
if ! command -v xcode-select &> /dev/null; then
    xcode-select --install
    print_success "Xcode Command Line Tools installed"
else
    print_success "Xcode Command Line Tools already installed"
fi
