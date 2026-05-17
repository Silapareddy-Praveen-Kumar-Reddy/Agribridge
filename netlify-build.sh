#!/usr/bin/env bash
set -euo pipefail

echo "🚀 Starting Netlify Flutter Web Build..."

# ==================== Install Flutter SDK ====================
if [ ! -d "$HOME/flutter" ]; then
  echo "📥 Installing Flutter SDK..."
  git clone https://github.com/flutter/flutter.git --depth 1 -b stable "$HOME/flutter"
else
  echo "✅ Flutter SDK already cached"
fi

# Add flutter to PATH
export PATH="$HOME/flutter/bin:$PATH"

# ==================== Configure Flutter ====================
echo "⚙️ Configuring Flutter..."
flutter config --no-analytics

# ==================== Precache Flutter Web ====================
echo "📦 Precaching Flutter web dependencies..."
flutter precache --web

# ==================== Build Web ====================
echo "🔨 Installing dependencies..."
flutter pub get

echo "🏗️ Building web version..."
flutter build web --release

echo "✅ Flutter web build completed successfully!"
echo "📁 Output available at: build/web"
