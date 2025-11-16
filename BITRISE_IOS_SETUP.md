# 🍎 BITRISE iOS BUILD SETUP - COMPLETE GUIDE

**Your ios_build workflow has been created! Follow these steps to complete it.**

---

## ✅ ALREADY COMPLETED:

1. ✅ Created `ios_build` workflow in Bitrise
2. ✅ Set Stack to: **Always latest stable Xcode version**
3. ✅ Set Machine to: **M2 Pro Large (6 CPU, 14GB RAM)**
4. ✅ Included basic steps: Git Clone, Node.js, npm install, lint, test, cache

---

## 🔧 STEPS TO ADD TO BITRISE WORKFLOW:

### **Step 1: Add iOS Platform**

**Click "+ Add Step" after "Save NPM Cache"**
- Search for: **Script**
- Title: `Add iOS Platform`
- Script content:
```bash
#!/usr/bin/env bash
set -ex

echo "Adding iOS platform to Capacitor project..."
npx cap add ios || echo "iOS platform already exists"
```

---

### **Step 2: Use iOS Config**

**Click "+ Add Step"**
- Search for: **Script**
- Title: `Use iOS Configuration`
- Script content:
```bash
#!/usr/bin/env bash
set -ex

echo "Switching to iOS Capacitor configuration..."
if [ -f "capacitor.config.ios.ts" ]; then
  cp capacitor.config.ios.ts capacitor.config.ts
  echo "✅ iOS config activated"
else
  echo "⚠️ capacitor.config.ios.ts not found"
fi
```

---

### **Step 3: Build Web Assets**

**Click "+ Add Step"**
- Search for: **Script**
- Title: `Build Web Assets`
- Script content:
```bash
#!/usr/bin/env bash
set -ex

echo "Building web assets for production..."
npm run build
```

---

### **Step 4: Sync Capacitor**

**Click "+ Add Step"**
- Search for: **Script**
- Title: `Sync Capacitor iOS`
- Script content:
```bash
#!/usr/bin/env bash
set -ex

echo "Syncing Capacitor with iOS project..."
npx cap sync ios
```

---

### **Step 5: Install CocoaPods Dependencies**

**Click "+ Add Step"**
- Search for: **Run CocoaPods install**
- Source root path: `ios/App`
- This installs iOS dependencies

---

### **Step 6: iOS Auto Provision with Apple ID**

**Click "+ Add Step"**
- Search for: **iOS Auto Provision with Apple ID**
- Or use: **Certificate and profile installer** (if you have manual certificates)

**For iOS Auto Provision:**
- Connect your Apple Developer account
- Select your team
- Bundle ID: `com.efeskebap.admin`

---

### **Step 7: Xcode Archive & Export**

**Click "+ Add Step"**
- Search for: **Xcode Archive & Export for iOS**

**Configuration:**
- **Project path:** `ios/App/App.xcworkspace`
- **Scheme:** `App`
- **Distribution method:** 
  - `development` (for testing)
  - `app-store` (for App Store)
  - `ad-hoc` (for TestFlight)
- **Export options:**
  - Team ID: Your Apple Developer Team ID
  - Upload Bitcode: `no`
  - Compile Bitcode: `no`

---

### **Step 8: Deploy to iTunes Connect (Optional)**

**Click "+ Add Step"**
- Search for: **Deploy to iTunes Connect**
- For App Store/TestFlight submission
- Requires Apple ID credentials

---

## 🔐 CODE SIGNING SETUP:

### **Option A: Automatic (Recommended)**

1. Go to **Bitrise Workflow Editor → Code Signing**
2. Click **"Connect to Apple Developer"**
3. Sign in with your Apple ID
4. Select your team
5. Bitrise will manage certificates automatically

### **Option B: Manual**

1. Generate certificates on developer.apple.com
2. Go to **Bitrise Workflow Editor → Code Signing**
3. Upload:
   - iOS Distribution Certificate (.p12)
   - Provisioning Profile (.mobileprovision)
   - Certificate password

---

## 🔥 FIREBASE iOS CONFIGURATION:

### **1. Download Firebase Config**

1. Go to [Firebase Console](https://console.firebase.google.com)
2. Select your project
3. Click iOS app settings (or add iOS app)
4. **Bundle ID:** `com.efeskebap.admin`
5. Download `GoogleService-Info.plist`

### **2. Add to Repository**

```bash
# Create iOS app directory
mkdir -p ios/App/App

# Copy Firebase config
cp /path/to/GoogleService-Info.plist ios/App/App/
```

### **3. Commit and Push**

```bash
git add ios/App/App/GoogleService-Info.plist
git commit -m "Add Firebase iOS configuration"
git push origin master
```

---

## ⚙️ ENV VARS TO ADD IN BITRISE:

Go to **Bitrise Workflow Editor → Env Vars**

Add these:
- `BITRISE_PROJECT_PATH`: `ios/App/App.xcworkspace`
- `BITRISE_SCHEME`: `App`
- `BITRISE_EXPORT_METHOD`: `development` (or `app-store`)
- `APPLE_TEAM_ID`: Your Apple Developer Team ID
- `BUNDLE_ID`: `com.efeskebap.admin`

---

## 🧪 TEST THE BUILD:

### **Run Build Manually:**

1. Go to Bitrise app dashboard
2. Select `ios_build` workflow
3. Click **"Start Build"**
4. Select branch: `master`
5. Watch the build progress

### **Expected Build Time:**
- First build: 10-15 minutes
- Subsequent builds: 5-8 minutes (with cache)

### **Build Cost:**
- M2 Pro Large: 4 credits/minute
- ~10 min build = 40 credits
- Your trial includes credits!

---

## 📱 AFTER SUCCESSFUL BUILD:

### **1. Download IPA**

- Go to build page
- Click **"Artifacts"** tab
- Download `.ipa` file

### **2. Install on Device**

- Use **TestFlight** (recommended)
- Or use **Xcode** to install directly

### **3. Test FCM Notifications**

- Install app on iOS device
- Check that FCM token is registered in database
- Send test order notification

---

## 🐛 TROUBLESHOOTING:

### **Build fails at CocoaPods:**
```bash
cd ios/App
pod repo update
pod install
```

### **Code signing error:**
- Check Apple Developer account
- Verify Bundle ID matches
- Ensure certificates are valid

### **Missing GoogleService-Info.plist:**
- Download from Firebase Console
- Add to `ios/App/App/` folder
- Commit to repository

### **Capacitor sync fails:**
- Ensure `npm run build` succeeded
- Check `capacitor.config.ios.ts` exists
- Verify iOS platform is added

---

## 📋 COMPLETE WORKFLOW STRUCTURE:

```yaml
ios_build:
  steps:
    1. Git Clone Repository
    2. Install Node.js
    3. Restore NPM Cache
    4. npm install
    5. npm run lint
    6. npm run test
    7. Save NPM Cache
    8. ✨ Add iOS Platform (Script)
    9. ✨ Use iOS Config (Script)
    10. ✨ Build Web Assets (Script)
    11. ✨ Sync Capacitor iOS (Script)
    12. ✨ Run CocoaPods install
    13. ✨ iOS Auto Provision
    14. ✨ Xcode Archive & Export
    15. ✨ (Optional) Deploy to iTunes Connect
```

---

## 🎯 QUICK CHECKLIST:

Before running build:
- [ ] iOS workflow created in Bitrise
- [ ] Stack set to Xcode (macOS)
- [ ] Machine set to M2 Pro Large
- [ ] All 8 iOS build steps added
- [ ] Apple Developer account connected
- [ ] Bundle ID configured: `com.efeskebap.admin`
- [ ] GoogleService-Info.plist in repository
- [ ] capacitor.config.ios.ts committed
- [ ] Run first build

After successful build:
- [ ] Download IPA artifact
- [ ] Install on iOS device
- [ ] Test app functionality
- [ ] Test FCM notifications
- [ ] Submit to TestFlight (optional)

---

## 🚀 AUTOMATION:

### **Trigger iOS builds automatically:**

1. Go to **Bitrise → Triggers**
2. Add trigger for `ios_build` workflow:
   - **Push to branch:** `master` or `main`
   - **Tag push:** `v*-ios`
   - **Pull request:** from `develop` to `master`

---

## 💰 COST ESTIMATE:

**Free Trial (until Dec 14, 2025):**
- Includes build credits
- No cost for testing builds
- M2 Pro Large available

**After Trial:**
- M2 Pro Large: 4 credits/min
- Average build: 10 min = 40 credits
- Pricing varies by plan

---

## 📞 SUPPORT:

- **Bitrise Docs:** https://docs.bitrise.io/
- **Capacitor iOS:** https://capacitorjs.com/docs/ios
- **Firebase iOS:** https://firebase.google.com/docs/ios/setup
- **Apple Developer:** https://developer.apple.com/support/

---

## ✅ SUCCESS CRITERIA:

When build completes successfully:
- ✅ Green checkmark on all steps
- ✅ IPA file generated in artifacts
- ✅ No code signing errors
- ✅ App installs on iOS device
- ✅ FCM notifications work

---

**Your iOS build infrastructure is ready! Just add the steps above in Bitrise and run your first build!** 🍎🚀✨
