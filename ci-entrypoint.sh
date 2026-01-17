#!/bin/bash
# CI Entrypoint Script for tw-idrinth
# Runs the same checks as GitHub Actions CI

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_header() {
    echo ""
    echo -e "${YELLOW}========================================${NC}"
    echo -e "${YELLOW}$1${NC}"
    echo -e "${YELLOW}========================================${NC}"
    echo ""
}

print_success() {
    echo -e "${GREEN}$1${NC}"
}

print_error() {
    echo -e "${RED}$1${NC}"
}

run_luacheck() {
    print_header "Running Luacheck"
    if luacheck .; then
        print_success "Luacheck passed!"
        return 0
    else
        print_error "Luacheck failed!"
        return 1
    fi
}

run_selene() {
    print_header "Running Selene"
    if selene .; then
        print_success "Selene passed!"
        return 0
    else
        print_error "Selene failed!"
        return 1
    fi
}

run_translations() {
    print_header "Checking Translations"
    if python3 scripts/check_unused_translations.py; then
        print_success "Translation check passed!"
        return 0
    else
        print_error "Translation check failed!"
        return 1
    fi
}

show_help() {
    echo "Usage: docker run <image> [command]"
    echo ""
    echo "Commands:"
    echo "  all           Run all CI checks (default)"
    echo "  luacheck      Run Luacheck only"
    echo "  selene        Run Selene only"
    echo "  translations  Run translation check only"
    echo "  lint          Run both Luacheck and Selene"
    echo "  help          Show this help message"
    echo ""
    echo "Examples:"
    echo "  docker build -t tw-idrinth-ci ."
    echo "  docker run -v \$(pwd):/workspace tw-idrinth-ci"
    echo "  docker run -v \$(pwd):/workspace tw-idrinth-ci luacheck"
    echo "  docker run -v \$(pwd):/workspace tw-idrinth-ci lint"
}

# Main execution
cd /workspace

case "${1:-all}" in
    all)
        FAILED=0
        run_luacheck || FAILED=1
        run_selene || FAILED=1
        run_translations || FAILED=1

        echo ""
        if [ $FAILED -eq 0 ]; then
            print_header "All CI checks passed!"
            exit 0
        else
            print_header "Some CI checks failed!"
            exit 1
        fi
        ;;
    luacheck)
        run_luacheck
        ;;
    selene)
        run_selene
        ;;
    translations)
        run_translations
        ;;
    lint)
        FAILED=0
        run_luacheck || FAILED=1
        run_selene || FAILED=1

        if [ $FAILED -eq 0 ]; then
            print_header "All lint checks passed!"
            exit 0
        else
            print_header "Some lint checks failed!"
            exit 1
        fi
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        echo "Unknown command: $1"
        show_help
        exit 1
        ;;
esac
