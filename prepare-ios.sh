#!/usr/bin/env bash

# iOS Preparation Script for Local Development
# Run this script before building iOS app locally or on CI/CD

set -e

echo "🍎 Preparing iOS build environment..."
echo ""

# Step 1: Check Node.js
echo "1️⃣  Checking Node.js installation..."
if command -v node &> /dev/null; then
    echo "✅ Node.js version: $(node --version)"
else
    echo "❌ Node.js is not installed!"
    exit 1
fi

# Step 2: Check npm
echo ""
echo "2️⃣  Checking npm installation..."
if command -v npm &> /dev/null; then
    echo "✅ npm version: $(npm --version)"
else
    echo "❌ npm is not installed!"
    exit 1
fi

# Step 3: Install dependencies
echo ""
echo "3️⃣  Installing npm dependencies..."
npm install

# Step 4: Check for iOS config
echo ""
echo "4️⃣  Checking iOS configuration..."
if [ -f "capacitor.config.ios.ts" ]; then
    echo "✅ capacitor.config.ios.ts found"
else
    echo "❌ capacitor.config.ios.ts not found!"
    exit 1
fi

# Step 5: Switch to iOS config
echo ""
echo "5️⃣  Switching to iOS configuration..."
cp capacitor.config.ios.ts capacitor.config.ts
echo "✅ iOS config activated"

# Step 6: Build web assets
echo ""
echo "6️⃣  Building web assets..."
npm run build
echo "✅ Web assets built"

# Step 7: Add iOS platform (if not exists)
echo ""
echo "7️⃣  Adding iOS platform..."
if [ -d "ios" ]; then
    echo "⚠️  iOS platform already exists, skipping..."
else
    npx cap add ios
    echo "✅ iOS platform added"
fi

# Step 8: Check for Firebase config
echo ""
echo "8️⃣  Checking Firebase iOS configuration..."
if [ -f "ios/App/App/GoogleService-Info.plist" ]; then
    echo "✅ GoogleService-Info.plist found"
else
    echo "⚠️  GoogleService-Info.plist NOT found!"
    echo "   Download it from Firebase Console and place it at:"
    echo "   ios/App/App/GoogleService-Info.plist"
fi

# Step 9: Sync Capacitor
echo ""
echo "9️⃣  Syncing Capacitor with iOS..."
npx cap sync ios
echo "✅ Capacitor sync complete"

# Step 10: Install CocoaPods dependencies
echo ""
echo "🔟 Installing CocoaPods dependencies..."
if command -v pod &> /dev/null; then
    cd ios/App
    pod install
    cd ../..
    echo "✅ CocoaPods dependencies installed"
else
    echo "⚠️  CocoaPods not installed. Install it with:"
    echo "   sudo gem install cocoapods"
fi

echo ""
echo "🎉 iOS build environment is ready!"
echo ""
echo "📱 Next steps:"
echo "   1. Open Xcode: npx cap open ios"
echo "   2. Select your development team in Xcode"
echo "   3. Connect your iOS device"
echo "   4. Build and run (⌘ + R)"
echo ""
echo "   Or build on Bitrise using the ios_build workflow"
echo ""
