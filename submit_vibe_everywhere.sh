#!/bin/bash

# === Constants ===
TOKEN_ADDR="0x8A09a9683B5401bf1fa80d1724c103c035A4EA22"
PAIR_ADDR="0x2c1B5c190D8a3B44F5855c578902AA67F3D0F37A"
CHAIN="base"

echo "🔥 VIBE GLOBAL SUBMISSION STARTED"

# === 1. GeckoTerminal ===
echo "🦎 Submitting to GeckoTerminal..."
curl -s -X POST "https://api.geckoterminal.com/api/v2/networks/$CHAIN/pools/submit" \
  -H "Content-Type: application/json" \
  -d "{\"pool_address\": \"$PAIR_ADDR\"}" \
  && echo "✅ GeckoTerminal submitted."

# === 2. DexScreener (Open Pair) ===
echo "📊 Opening DexScreener for indexing..."
open "https://dexscreener.com/$CHAIN/$PAIR_ADDR"

# === 3. 1inch Token PR (manual) ===
echo "🧩 Opening 1inch token PR repo..."
open "https://github.com/1inch/tokenlists"

# === 4. CoinGecko Submission Form ===
echo "🧊 Opening CoinGecko Token Submission..."
open "https://coingecko.com/en/coins/new"

# === 5. CoinMarketCap Form ===
echo "📈 Opening CoinMarketCap form..."
open "https://coinmarketcap.com/currencies/"

# === 6. TrustWallet Assets Repo ===
echo "👛 Opening TrustWallet repo..."
open "https://github.com/trustwallet/assets"

# === 7. DexTools Pair Submit ===
echo "📉 Opening DexTools Pair Submit Page..."
open "https://www.dextools.io/app/en/submit/pair"

# === 8. GeckoTools Auto-Check ===
echo "🔁 Verifying GeckoTerminal status..."
curl -s "https://api.geckoterminal.com/api/v2/networks/$CHAIN/pools/$PAIR_ADDR"

# === 9. GitHub Sync ===
echo "🐙 Syncing latest VIBE commit..."
cd ~/vibe_os/VIBE-1.0
git add .
git commit -m "🛰️ VIBE Global Sync Commit"
git push origin main

echo "✅ All actions executed. VIBE is broadcasting globally. Shill time. 💥"

