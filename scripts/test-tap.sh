#!/bin/bash
set -euo pipefail

# Test script for homebrew-markview tap
# Usage: bash scripts/test-tap.sh
# Validates: tap, install, binary, audit, uninstall

PASS=0
FAIL=0
TAP="paulhkang94/markview"
FORMULA="paulhkang94/markview/markview"

pass() { echo "  ✓ $1"; PASS=$((PASS + 1)); }
fail() { echo "  ✗ $1"; FAIL=$((FAIL + 1)); }

echo "=== Homebrew Tap Test Suite ==="
echo ""

# Clean state
echo "--- Setup ---"
brew uninstall markview 2>/dev/null || true
brew untap "$TAP" 2>/dev/null || true

# Test 1: Tap
echo ""
echo "--- Test: brew tap ---"
if brew tap "$TAP" 2>&1; then
    pass "tap succeeded"
else
    fail "tap failed"
fi

# Test 2: Formula info
echo ""
echo "--- Test: brew info ---"
INFO=$(brew info markview 2>&1 || true)
if echo "$INFO" | grep -q "stable 1.0.0"; then
    pass "formula version is 1.0.0"
else
    fail "formula version mismatch"
fi
if echo "$INFO" | grep -q "MIT"; then
    pass "license is MIT"
else
    fail "license missing"
fi

# Test 3: Install
echo ""
echo "--- Test: brew install ---"
if brew install "$FORMULA" 2>&1; then
    pass "install succeeded"
else
    fail "install failed"
fi

# Test 4: Binary exists and is executable
echo ""
echo "--- Test: binary ---"
if [ -x "$(brew --prefix)/bin/markview" ]; then
    pass "binary exists and is executable"
else
    fail "binary missing or not executable"
fi

BINARY_TYPE=$(file "$(brew --prefix)/bin/markview" 2>/dev/null || true)
if echo "$BINARY_TYPE" | grep -q "Mach-O.*arm64"; then
    pass "binary is arm64 Mach-O"
elif echo "$BINARY_TYPE" | grep -q "Mach-O"; then
    pass "binary is Mach-O (x86)"
else
    fail "binary is not Mach-O: $BINARY_TYPE"
fi

# Test 5: brew test
echo ""
echo "--- Test: brew test ---"
if brew test markview 2>&1; then
    pass "brew test passed"
else
    fail "brew test failed"
fi

# Test 6: Uninstall
echo ""
echo "--- Test: uninstall ---"
if brew uninstall markview 2>&1; then
    pass "uninstall succeeded"
else
    fail "uninstall failed"
fi

if [ ! -x "$(brew --prefix)/bin/markview" ]; then
    pass "binary removed after uninstall"
else
    fail "binary still exists after uninstall"
fi

# Summary
echo ""
echo "=== Results: $PASS passed, $FAIL failed ==="
[ "$FAIL" -eq 0 ] && exit 0 || exit 1
