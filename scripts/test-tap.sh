#!/bin/bash
set -euo pipefail

# Test script for homebrew-markview tap
# Usage: bash scripts/test-tap.sh [--formula-only | --cask-only | --all]
# Validates: tap, install, binary/app, audit, uninstall for both formula and cask

PASS=0
FAIL=0
TAP="paulhkang94/markview"
FORMULA="paulhkang94/markview/markview"
MODE="${1:---all}"

pass() { echo "  ✓ $1"; PASS=$((PASS + 1)); }
fail() { echo "  ✗ $1"; FAIL=$((FAIL + 1)); }

echo "=== Homebrew Tap Test Suite (mode: $MODE) ==="
echo ""

# Clean state
echo "--- Setup ---"
brew uninstall markview 2>/dev/null || true
brew uninstall --cask markview 2>/dev/null || true
rm -rf /Applications/MarkView.app 2>/dev/null || true
brew untap "$TAP" 2>/dev/null || true

# Test: Tap
echo ""
echo "--- Test: brew tap ---"
if brew tap "$TAP" 2>&1; then
    pass "tap succeeded"
else
    fail "tap failed"
fi

# ============================================================
# FORMULA TESTS
# ============================================================
if [[ "$MODE" == "--all" || "$MODE" == "--formula-only" ]]; then
    echo ""
    echo "========== FORMULA TESTS =========="

    # Formula info
    echo ""
    echo "--- Test: formula info ---"
    INFO=$(brew info markview 2>&1 || true)
    if echo "$INFO" | grep -q "stable 1.0.0"; then
        pass "formula version is 1.0.0"
    else
        fail "formula version mismatch"
    fi
    if echo "$INFO" | grep -q "MIT"; then
        pass "formula license is MIT"
    else
        fail "formula license missing"
    fi

    # Formula install
    echo ""
    echo "--- Test: formula install ---"
    if brew install "$FORMULA" 2>&1; then
        pass "formula install succeeded"
    else
        fail "formula install failed"
    fi

    # Binary check
    echo ""
    echo "--- Test: formula binary ---"
    if [ -x "$(brew --prefix)/bin/markview" ]; then
        pass "binary exists and is executable"
    else
        fail "binary missing or not executable"
    fi

    BINARY_TYPE=$(file "$(brew --prefix)/bin/markview" 2>/dev/null || true)
    if echo "$BINARY_TYPE" | grep -q "Mach-O"; then
        pass "binary is Mach-O"
    else
        fail "binary is not Mach-O: $BINARY_TYPE"
    fi

    # brew test
    echo ""
    echo "--- Test: brew test ---"
    if brew test markview 2>&1; then
        pass "brew test passed"
    else
        fail "brew test failed"
    fi

    # Formula uninstall
    echo ""
    echo "--- Test: formula uninstall ---"
    if brew uninstall markview 2>&1; then
        pass "formula uninstall succeeded"
    else
        fail "formula uninstall failed"
    fi

    if [ ! -x "$(brew --prefix)/bin/markview" ]; then
        pass "binary removed after uninstall"
    else
        fail "binary still exists after uninstall"
    fi
fi

# ============================================================
# CASK TESTS
# ============================================================
if [[ "$MODE" == "--all" || "$MODE" == "--cask-only" ]]; then
    echo ""
    echo "========== CASK TESTS =========="

    # Cask info
    echo ""
    echo "--- Test: cask info ---"
    CASK_INFO=$(brew info --cask paulhkang94/markview/markview 2>&1 || true)
    if echo "$CASK_INFO" | grep -q "1.0.0"; then
        pass "cask version is 1.0.0"
    else
        fail "cask version mismatch"
    fi

    # Cask install
    echo ""
    echo "--- Test: cask install ---"
    rm -rf /Applications/MarkView.app 2>/dev/null || true
    if brew install --cask paulhkang94/markview/markview 2>&1; then
        pass "cask install succeeded"
    else
        fail "cask install failed"
    fi

    # App bundle verification
    echo ""
    echo "--- Test: app bundle ---"
    if [ -d "/Applications/MarkView.app" ]; then
        pass "MarkView.app exists in /Applications"
    else
        fail "MarkView.app not found"
    fi

    if [ -x "/Applications/MarkView.app/Contents/MacOS/MarkView" ]; then
        pass "app executable exists"
    else
        fail "app executable missing"
    fi

    if [ -f "/Applications/MarkView.app/Contents/Info.plist" ]; then
        pass "Info.plist exists"
    else
        fail "Info.plist missing"
    fi

    if plutil -lint "/Applications/MarkView.app/Contents/Info.plist" >/dev/null 2>&1; then
        pass "Info.plist is valid"
    else
        fail "Info.plist is invalid"
    fi

    # Quick Look extension
    if [ -d "/Applications/MarkView.app/Contents/PlugIns/MarkViewQuickLook.appex" ]; then
        pass "Quick Look extension present"
    else
        fail "Quick Look extension missing"
    fi

    # App binary type
    APP_TYPE=$(file "/Applications/MarkView.app/Contents/MacOS/MarkView" 2>/dev/null || true)
    if echo "$APP_TYPE" | grep -q "Mach-O"; then
        pass "app binary is Mach-O"
    else
        fail "app binary is not Mach-O"
    fi

    # Cask uninstall
    echo ""
    echo "--- Test: cask uninstall ---"
    if brew uninstall --cask markview 2>&1; then
        pass "cask uninstall succeeded"
    else
        fail "cask uninstall failed"
    fi

    if [ ! -d "/Applications/MarkView.app" ]; then
        pass "MarkView.app removed after uninstall"
    else
        fail "MarkView.app still exists after uninstall"
    fi
fi

# Summary
echo ""
echo "=== Results: $PASS passed, $FAIL failed ==="
[ "$FAIL" -eq 0 ] && exit 0 || exit 1
