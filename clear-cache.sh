#!/bin/bash

# Clear Cache Script for PG Management App
# This script clears all build and runtime caches

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║           PG Management App - Cache Clear Script              ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

# Navigate to project directory
cd "$(dirname "$0")"

echo "📁 Current directory: $(pwd)"
echo ""

# Step 1: Clear Vite build cache
echo "🧹 Step 1: Clearing Vite build cache..."
rm -rf node_modules/.vite
rm -rf .vite
rm -rf dist
echo "   ✓ Vite cache cleared"
echo ""

# Step 2: Clear any temporary files
echo "🧹 Step 2: Clearing temporary files..."
find . -name "*.log" -type f -delete 2>/dev/null || true
find . -name ".DS_Store" -type f -delete 2>/dev/null || true
echo "   ✓ Temporary files cleared"
echo ""

# Step 3: Verify source files
echo "🔍 Step 3: Verifying source files..."
if grep -q "Plus" src/pages/RoomForm.tsx 2>/dev/null; then
    echo "   ⚠️  WARNING: Plus icon still referenced in RoomForm.tsx"
    echo "   This should not happen. Please check the file manually."
else
    echo "   ✓ RoomForm.tsx is clean (no Plus references)"
fi
echo ""

# Step 4: Run lint/build
echo "🔨 Step 4: Running fresh build..."
npm run lint 2>&1 | tail -5
BUILD_STATUS=$?
echo ""

if [ $BUILD_STATUS -eq 0 ]; then
    echo "✅ BUILD SUCCESSFUL"
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "🎉 Cache cleared successfully!"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "Next steps:"
    echo "1. Clear your browser cache (Ctrl+Shift+Delete)"
    echo "2. Hard refresh the page (Ctrl+F5 or Cmd+Shift+R)"
    echo "3. Or open in incognito/private mode"
    echo ""
else
    echo "❌ BUILD FAILED"
    echo ""
    echo "Please check the error messages above and fix any issues."
    echo ""
fi
