# 🚀 Agribridge CI/CD Setup Guide

Complete guide to set up automated build and deployment pipelines for Android, iOS, and Web.

## 📋 Table of Contents
1. [GitHub Secrets Setup](#github-secrets-setup)
2. [Android Deployment](#android-deployment)
3. [iOS Deployment](#ios-deployment)
4. [Web Deployment (Netlify)](#web-deployment-netlify)
5. [Workflow Overview](#workflow-overview)
6. [Troubleshooting](#troubleshooting)

---

## 🔐 GitHub Secrets Setup

All sensitive data is stored as GitHub Secrets. Navigate to:
**Settings → Secrets and variables → Actions**

### Required Secrets for All Platforms

```
GITHUB_TOKEN          # Auto-generated, no action needed
```

---

## 🤖 Android Deployment

### Step 1: Generate Android Keystore

```bash
# Generate keystore (one-time setup)
keytool -genkey -v -keystore ~/key.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias agribridge-key

# Convert to Base64 for GitHub Secrets
base64 -i ~/key.jks | pbcopy  # macOS
# OR
base64 ~/key.jks > key.base64  # Linux/Windows
```

### Step 2: Add GitHub Secrets

Add these secrets to your GitHub repository:

| Secret Name | Value | Where to Get |
|------------|-------|-------------|
| `ANDROID_KEYSTORE_BASE64` | Base64 encoded keystore file | Generated above |
| `KEYSTORE_PASSWORD` | Password you created for keystore | Your chosen password |
| `KEY_ALIAS` | The alias you gave the key (e.g., `agribridge-key`) | Generated above |
| `KEY_PASSWORD` | Password for the key | Your chosen password |

### Step 3: Create Google Play Service Account

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project
3. Enable Google Play Android Developer API
4. Create a Service Account:
   - **IAM & Admin → Service Accounts → Create Service Account**
   - Grant `Editor` role
5. Create JSON key:
   - Click the service account
   - **Keys → Add Key → JSON**
   - Download the JSON file

### Step 4: Add Play Store Secret

| Secret Name | Value |
|------------|-------|
| `PLAY_STORE_SERVICE_ACCOUNT` | Content of the JSON file (copy entire file) |

### Step 5: Update Package Name

In `.github/workflows/google-play-deploy.yml`, replace:
```yaml
packageName: com.agribridge.app  # ← Update with your actual package name
```

Find your package name in `android/app/build.gradle`:
```gradle
applicationId "com.yourcompany.agribridge"
```

### Step 6: Publish on Google Play Console

1. Go to [Google Play Console](https://play.google.com/console)
2. Create a new app
3. Fill in app details (name, description, screenshots, etc.)
4. Set up pricing and distribution
5. Create internal test track first (safer)

### Trigger Android Deployment

```bash
# Push tag to trigger automatic deployment
git tag -a v1.0.0 -m "Release version 1.0.0"
git push origin v1.0.0
```

Or manually trigger:
- GitHub → Actions → "Deploy to Google Play Store" → Run workflow

---

## 📱 iOS Deployment

### Step 1: Generate iOS Certificates & Profiles

1. Go to [Apple Developer Account](https://developer.apple.com/account)
2. **Certificates, Identifiers & Profiles**

#### Generate Certificate Signing Request (CSR)
```bash
# On your Mac
# Keychain Access → Certificate Assistant → Request a Certificate from a Certificate Authority
# Fill in email and save to disk
```

#### Create App ID
1. Go to **Identifiers → App IDs**
2. Click **+** to register a new App ID
3. Enter Bundle ID: `com.yourcompany.agribridge`
4. Enable necessary capabilities (Push Notifications, etc.)

#### Create Certificates
1. **Certificates → iOS Distribution**
2. Upload your CSR
3. Download the certificate

#### Create Provisioning Profile
1. **Provisioning Profiles → App Store**
2. Select your App ID
3. Select the certificate you just created
4. Download the profile

### Step 2: Convert Certificates for GitHub

```bash
# Export Certificate from Keychain as .p12
# Then convert to Base64:
base64 -i certificate.p12 | pbcopy  # macOS
# OR
base64 certificate.p12 > cert.base64  # Linux
```

### Step 3: Create App Store Connect API Key

1. Go to [App Store Connect](https://appstoreconnect.apple.com/)
2. **Users and Access → Keys**
3. Click **+** to generate new key
4. Role: **Developer** or **App Manager**
5. Download the key file (save as `AuthKey_KEYID.p8`)

### Step 4: Add GitHub Secrets

| Secret Name | Value | Where to Get |
|------------|-------|-------------|
| `IOS_CERTIFICATE_BASE64` | Base64 encoded .p12 file | Generated above |
| `IOS_CERTIFICATE_PASSWORD` | Password for .p12 file | Your chosen password |
| `APPSTORE_ISSUER_ID` | Issuer ID | App Store Connect → Keys |
| `APPSTORE_API_KEY_ID` | Key ID | App Store Connect → Keys |
| `APPSTORE_API_PRIVATE_KEY` | Content of AuthKey_KEYID.p8 file | Downloaded file |

### Step 5: Update Bundle ID

In `.github/workflows/app-store-deploy.yml`, replace:
```yaml
bundle-id: com.agribridge.app  # ← Update with your actual bundle ID
```

Also update in `ios/Runner.xcodeproj/project.pbxproj` and Xcode settings.

### Step 6: Create App on App Store Connect

1. Go to [App Store Connect](https://appstoreconnect.apple.com/)
2. **My Apps → +** to add new app
3. Fill in app name, bundle ID, SKU, etc.
4. Complete app information (screenshots, description, ratings, etc.)

### Trigger iOS Deployment

```bash
# Push tag to trigger automatic deployment
git tag -a v1.0.0 -m "Release version 1.0.0"
git push origin v1.0.0
```

Or manually trigger:
- GitHub → Actions → "Deploy to Apple App Store" → Run workflow

---

## 🌐 Web Deployment (Netlify)

### Step 1: Create Netlify Account

1. Go to [netlify.com](https://netlify.com)
2. Sign up with GitHub account
3. Authorize Netlify to access your repositories

### Step 2: Get Netlify Tokens

1. **User Menu → Account Settings → Applications**
2. **Personal access tokens → New access token**
3. Generate a token with `deploy` scope

### Step 3: Add GitHub Secrets

| Secret Name | Value |
|------------|-------|
| `NETLIFY_AUTH_TOKEN` | Token from Netlify |
| `NETLIFY_SITE_ID` | Found in Site Settings → General → Site ID |

### Step 4: Create Netlify Site

1. Go to [netlify.com/app](https://netlify.com/app)
2. **Add new site → Import an existing project**
3. Connect your GitHub repo
4. Build settings should auto-detect:
   - **Build command**: `flutter build web`
   - **Publish directory**: `build/web`

### Step 5: Auto-Deploy on Push

The workflow will automatically deploy to Netlify when you push to `main` branch.

Check deployment status: **Netlify → Site Settings → Deploys**

---

## 📊 Workflow Overview

### 1. **flutter-ci.yml** - Main CI/CD Pipeline
Runs on every push and pull request:

```mermaid
graph LR
    A[Push/PR] --> B[Test & Lint]
    B --> C{Push to main?}
    C -->|Yes| D[Build Android APK]
    C -->|Yes| E[Build iOS App]
    C -->|Yes| F[Build Web]
    D --> G[Create Release]
    E --> G
    F --> G
    F --> H[Deploy to Netlify]
```

**Triggers:**
- On push to `main` or `develop`
- On pull requests to `main` or `develop`

**Jobs:**
- ✅ Test & Lint (all runs)
- 📦 Build Android APK (main branch only)
- 🍎 Build iOS App (main branch only)
- 🌐 Build Web (main branch only)
- 📝 Create Release (main branch only)

### 2. **google-play-deploy.yml** - Android Release
Deploys to Google Play Store

**Triggers:**
- Manual workflow dispatch
- Push of version tags (e.g., `v1.0.0`)

**Uploads to:** Google Play Console (internal track)

### 3. **app-store-deploy.yml** - iOS Release
Deploys to Apple App Store

**Triggers:**
- Manual workflow dispatch
- Push of version tags (e.g., `v1.0.0`)

**Uploads to:** App Store Connect (requires manual review)

---

## 🎯 Quick Start Checklist

### First Time Setup

- [ ] Generate Android keystore
- [ ] Add Android secrets to GitHub
- [ ] Create Google Play Service Account
- [ ] Add Play Store secret to GitHub
- [ ] Update Android package name in workflows
- [ ] Create Google Play app entry
- [ ] Generate iOS certificates and profiles
- [ ] Create App Store Connect API key
- [ ] Add iOS secrets to GitHub
- [ ] Update iOS bundle ID in workflows
- [ ] Create App Store Connect app entry
- [ ] Create Netlify account
- [ ] Generate Netlify auth token
- [ ] Add Netlify secrets to GitHub
- [ ] Connect Netlify to GitHub repo

### Deployment Steps

1. **For Testing:**
   ```bash
   git push origin develop
   ```
   → Runs tests and builds, but doesn't deploy

2. **For Web Release:**
   ```bash
   git push origin main
   ```
   → Auto-deploys web to Netlify

3. **For Mobile Release:**
   ```bash
   git tag -a v1.0.0 -m "Release v1.0.0"
   git push origin v1.0.0
   ```
   → Triggers Android & iOS deployment workflows

---

## 🆘 Troubleshooting

### Android Issues

**Problem:** Build fails with "Keystore not found"
```
Solution: Verify ANDROID_KEYSTORE_BASE64 secret is properly encoded
base64 key.jks | wc -c  # Should be large number
```

**Problem:** Upload fails to Play Store
```
Solution: 
1. Check PLAY_STORE_SERVICE_ACCOUNT JSON is valid
2. Verify app exists in Play Console
3. Check package name matches exactly
```

### iOS Issues

**Problem:** Code signing fails
```
Solution:
1. Verify IOS_CERTIFICATE_BASE64 is proper .p12 file
2. Check IOS_CERTIFICATE_PASSWORD is correct
3. Ensure certificate is not expired
```

**Problem:** API key authentication fails
```
Solution:
1. Verify APPSTORE_ISSUER_ID format
2. Check APPSTORE_API_PRIVATE_KEY includes -----BEGIN PRIVATE KEY-----
3. Ensure key hasn't been revoked
```

### Web/Netlify Issues

**Problem:** Netlify deployment fails
```
Solution:
1. Check NETLIFY_AUTH_TOKEN is still valid
2. Verify NETLIFY_SITE_ID is correct
3. Ensure build command produces build/web directory
```

**Problem:** Workflow shows success but site not updating
```
Solution:
1. Check Netlify site settings for correct build command
2. Clear Netlify cache: Site Settings → Deploys → Clear cache & redeploy
3. Verify main branch is set in Netlify
```

### General GitHub Actions Issues

**Problem:** Workflow not triggering
```
Solution:
1. Check branch name matches workflow condition
2. Verify tag format matches (v1.0.0)
3. Check GitHub Secrets are properly set
```

**Problem:** "Insufficient permissions" error
```
Solution:
1. Go to Settings → Actions → General
2. Ensure "Workflow permissions" is set to "Read and write permissions"
```

---

## 📚 Useful Links

- [Flutter Documentation](https://flutter.dev/docs)
- [Google Play Console](https://play.google.com/console)
- [App Store Connect](https://appstoreconnect.apple.com)
- [Netlify](https://netlify.com)
- [GitHub Actions](https://docs.github.com/en/actions)
- [Apple Developer Account](https://developer.apple.com/account)
- [Google Cloud Console](https://console.cloud.google.com)

---

## 📞 Support

For issues or questions:
1. Check the [Troubleshooting](#troubleshooting) section
2. Review workflow logs: GitHub → Actions → Select workflow → View logs
3. Check app store console for detailed error messages
4. Consult official documentation links above

---

**Last Updated:** 2026-05-17
**Flutter Version:** 3.22.x
**Status:** Production Ready ✅
