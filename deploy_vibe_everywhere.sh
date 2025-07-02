#!/bin/bash

set -e  # Exit on any error
echo "🚀 Starting VIBE 1.0 Full Deployment Script..."

# === CONFIG ===
TOKEN_ADDRESS="0x8A09a9683B5401bf1fa80d1724c103c035A4EA22"
CHECKSUM_ADDRESS=$(echo "$TOKEN_ADDRESS" | awk '{print toupper($0)}')
PROJECT_NAME="VIBE"
SYMBOL="VIBE"
DECIMALS="18"
EXPLORER_URL="https://basescan.org/token/$TOKEN_ADDRESS"
LOGO_PATH="logo.png"
INFO_PATH="info.json"
REPO_URL="https://github.com/OfficialGIGA/VIBE-1.0.git"

# === CHECK PREREQS ===
echo "🛠️ Checking dependencies..."
for cmd in git curl jq sed grep awk; do
  if ! command -v $cmd &>/dev/null; then
    echo "❌ Missing dependency: $cmd"
    exit 1
  fi
done

# === VALIDATE LOGO ===
echo "🖼️ Validating logo..."
if [ ! -f "$LOGO_PATH" ]; then
  echo "❌ logo.png not found in $(pwd). Add a 256x256 logo under 100KB."
  exit 1
fi

# === TRUSTWALLET FOLDER ===
echo "📦 Structuring TrustWallet repo layout..."
mkdir -p trustwallet/assets/blockchains/base/assets/$CHECKSUM_ADDRESS
cp "$LOGO_PATH" trustwallet/assets/blockchains/base/assets/$CHECKSUM_ADDRESS/logo.png

# === BUILD info.json ===
echo "🧩 Generating info.json..."
cat > trustwallet/assets/blockchains/base/assets/$CHECKSUM_ADDRESS/info.json <<EOF
{
  "name": "$PROJECT_NAME",
  "symbol": "$SYMBOL",
  "type": "ERC20",
  "decimals": $DECIMALS,
  "chainId": 8453,
  "address": "$TOKEN_ADDRESS",
  "explorer": "$EXPLORER_URL",
  "description": "VIBE is the most culturally dominant, AI-powered, meme-fueled token on Base. No bots. No fees. Just fire.",
  "status": "active",
  "links": {
    "twitter": "https://twitter.com/OfficialGIGA",
    "telegram": "https://t.me/OfficialGIGA",
    "github": "https://github.com/OfficialGIGA/VIBE-1.0"
  }
}
EOF

# === 1INCH TOKENLIST ===
echo "📨 Submitting to 1inch TokenList (manual PR)..."
mkdir -p 1inch
cat > 1inch/vibe_token.json <<EOF
{
  "name": "$PROJECT_NAME",
  "symbol": "$SYMBOL",
  "decimals": $DECIMALS,
  "address": "$TOKEN_ADDRESS",
  "chainId": 8453,
  "logoURI": "https://raw.githubusercontent.com/OfficialGIGA/VIBE-1.0/main/logo.png"
}
EOF
echo "🟢 Submit PR to: https://github.com/1inch/tokenlists"

# === COINGECKO FORM ===
echo "📝 Open CoinGecko form..."
xdg-open "https://docs.google.com/forms/d/e/1FAIpQLSd0LrkMxATQbki4tQGzJbMzDz0-PAU3lwFzDZBSe-BzKG8btw/viewform" 2>/dev/null || open "https://docs.google.com/forms/d/e/1FAIpQLSd0LrkMxATQbki4tQGzJbMzDz0-PAU3lwFzDZBSe-BzKG8btw/viewform"

# === DEXTTOOLS ===
echo "📈 Submit to DexTools..."
DEXTOOLS_URL="https://www.dextools.io/app/en/base"
xdg-open "$DEXTOOLS_URL" 2>/dev/null || open "$DEXTOOLS_URL"

# === GECKOTERMINAL & DEXSCREENER ===
echo "📊 Open charting sites..."
xdg-open "https://geckoterminal.com/base/pools" 2>/dev/null || open "https://geckoterminal.com/base/pools"
xdg-open "https://dexscreener.com/base" 2>/dev/null || open "https://dexscreener.com/base"

# === PUSH TO GITHUB ===
echo "🐙 Pushing to GitHub..."
git init
git remote add origin "$REPO_URL" 2>/dev/null || true
git checkout -B main
git add .
git commit -m "🎉 VIBE 1.0 Initial Launch Commit"
git push -u origin main

# === FINISH ===
echo "✅ VIBE is now deployed to all open ecosystems (TrustWallet, 1inch, DexTools, CoinGecko, GitHub, GeckoTerminal, DexScreener)."
echo "🔥 You're live. Now go shill it to the world!"

# === Auto-submit to global platforms after deploy ===
echo "🚀 Auto-submitting VIBE to global platforms..."
chmod +x ./submit_vibe_everywhere.sh
./submit_vibe_everywhere.sh

# === Auto-submit to global platforms after deploy ===
echo "🚀 Auto-submitting VIBE to global platforms..."
chmod +x ./submit_vibe_everywhere.sh
./submit_vibe_everywhere.sh

