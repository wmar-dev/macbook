#!/bin/bash

# Safe Disk Space Cleanup
# Clears package manager caches, build artifacts, and other safely
# reclaimable space (uv/pip/npm/brew style "cache clean" operations).
# Nothing here deletes source code, settings, or data you created.
# Usage: bash clean-disk-space.sh

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

print_info() {
    echo -e "$1"
}

show_disk_usage() {
    df -h / | awk 'NR==1 || NR==2'
}

# Show how big the caches are before touching anything
show_cache_sizes() {
    print_header "Current Cache Sizes"
    for d in \
        "$HOME/Library/Caches/uv" \
        "$HOME/Library/Caches/pip" \
        "$HOME/.npm" \
        "$HOME/Library/Caches/node-gyp" \
        "$HOME/Library/Caches/Homebrew" \
        "$HOME/.cargo/registry" \
        "$HOME/go/pkg/mod" \
        "$HOME/Library/Developer/Xcode/DerivedData" \
        "$HOME/.cache/huggingface" \
        "$HOME/Library/Logs" \
        "$HOME/.Trash"
    do
        if [ -d "$d" ]; then
            du -sh "$d" 2>/dev/null
        fi
    done
}

clean_uv() {
    if command -v uv &> /dev/null; then
        print_header "Cleaning uv cache"
        uv cache clean && print_success "uv cache cleaned"
    else
        print_warning "uv not found, skipping"
    fi
}

clean_pip() {
    print_header "Cleaning pip cache"
    if command -v pip3 &> /dev/null; then
        pip3 cache purge && print_success "pip cache cleaned"
    elif command -v pip &> /dev/null; then
        pip cache purge && print_success "pip cache cleaned"
    else
        print_warning "pip not found, skipping"
    fi
}

clean_npm() {
    if command -v npm &> /dev/null; then
        print_header "Cleaning npm cache"
        npm cache clean --force && print_success "npm cache cleaned"
        if [ -d "$HOME/Library/Caches/node-gyp" ]; then
            rm -rf "$HOME/Library/Caches/node-gyp"
            print_success "node-gyp cache removed"
        fi
    else
        print_warning "npm not found, skipping"
    fi
}

clean_homebrew() {
    if command -v brew &> /dev/null; then
        print_header "Cleaning Homebrew"
        brew cleanup -s && print_success "Homebrew cache cleaned"
        brew autoremove && print_success "Unused Homebrew dependencies removed"
    else
        print_warning "brew not found, skipping"
    fi
}

clean_cargo() {
    if command -v cargo-cache &> /dev/null; then
        print_header "Cleaning cargo cache"
        cargo cache -a && print_success "cargo cache cleaned"
    elif command -v cargo &> /dev/null; then
        print_warning "cargo found but 'cargo-cache' isn't installed (run: cargo install cargo-cache), skipping"
    else
        print_warning "cargo not found, skipping"
    fi
}

clean_go() {
    if command -v go &> /dev/null; then
        print_header "Cleaning Go module cache"
        go clean -modcache && print_success "Go module cache cleaned"
    else
        print_warning "go not found, skipping"
    fi
}

clean_docker() {
    if command -v docker &> /dev/null; then
        print_header "Cleaning Docker (dangling images/containers/networks)"
        docker system prune -f && print_success "Docker cleaned"
        print_info "Note: run 'docker system prune -a' separately to also remove unused (but tagged) images"
    else
        print_warning "docker not found, skipping"
    fi
}

clean_xcode_derived_data() {
    if [ -d "$HOME/Library/Developer/Xcode/DerivedData" ]; then
        print_header "Cleaning Xcode DerivedData"
        rm -rf "$HOME/Library/Developer/Xcode/DerivedData"/*
        print_success "Xcode DerivedData cleaned"
    else
        print_warning "No Xcode DerivedData found, skipping"
    fi
}

clean_hugging_face() {
    if [ -d "$HOME/.cache/huggingface" ]; then
        print_header "Cleaning Hugging Face cache"
        rm -rf "$HOME/.cache/huggingface"/*
        print_success "Hugging Face cache cleaned"
    else
        print_warning "No Hugging Face cache found, skipping"
    fi
}

run_all() {
    clean_uv
    clean_pip
    clean_npm
    clean_homebrew
    clean_cargo
    clean_go
    clean_docker
    clean_xcode_derived_data
    clean_hugging_face
}

# Main menu
print_header "Safe Disk Space Cleanup"
print_info "Disk usage before:"
show_disk_usage

echo ""
echo "Select what to clean:"
echo "1) uv cache"
echo "2) pip cache"
echo "3) npm cache (+ node-gyp)"
echo "4) Homebrew cache + unused deps"
echo "5) cargo cache (requires cargo-cache)"
echo "6) Go module cache"
echo "7) Docker (dangling images/containers)"
echo "8) Xcode DerivedData"
echo "9) Hugging Face cache"
echo "10) Show cache sizes only (no changes)"
echo "A) All of the above (1-9)"
echo "0) Cancel"
echo ""

read -p "Enter your choices (comma-separated, e.g., 1,3,4): " choices

if [[ "$choices" == "A" || "$choices" == "a" ]]; then
    run_all
elif [[ "$choices" == "0" ]]; then
    print_warning "Cancelled"
    exit 0
else
    IFS=',' read -ra CHOICE_ARRAY <<< "$choices"
    for choice in "${CHOICE_ARRAY[@]}"; do
        case "$(echo "$choice" | xargs)" in
            1) clean_uv ;;
            2) clean_pip ;;
            3) clean_npm ;;
            4) clean_homebrew ;;
            5) clean_cargo ;;
            6) clean_go ;;
            7) clean_docker ;;
            8) clean_xcode_derived_data ;;
            9) clean_hugging_face ;;
            10) show_cache_sizes ;;
            *) print_warning "Unknown option: $choice" ;;
        esac
    done
fi

print_header "Done"
print_info "Disk usage after:"
show_disk_usage
