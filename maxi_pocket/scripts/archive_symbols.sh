#!/usr/bin/env bash
# Moves .symbols / .dSYM output from build/ into symbols/<version>_<build>/{android,ios}/

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
PUBSPEC="$PROJECT_ROOT/pubspec.yaml"
BUILD_DIR="$PROJECT_ROOT/build"
SYMBOLS_STORE="$PROJECT_ROOT/symbols"

# ── Parse version from pubspec.yaml ─────────────────────────────────────────
VERSION_LINE=$(grep "^version:" "$PUBSPEC" | head -1)
VERSION_FULL=$(echo "$VERSION_LINE" | sed 's/version:[[:space:]]*//')
VERSION_NAME=$(echo "$VERSION_FULL" | cut -d'+' -f1)
BUILD_NUMBER=$(echo "$VERSION_FULL" | cut -d'+' -f2)
RELEASE_SLUG="${VERSION_NAME}_${BUILD_NUMBER}"
RELEASE_DIR="$SYMBOLS_STORE/$RELEASE_SLUG"

echo "[archive_symbols] version=$VERSION_NAME build=$BUILD_NUMBER → $RELEASE_SLUG"

# ── Create destination directories ──────────────────────────────────────────
mkdir -p "$RELEASE_DIR/android"
mkdir -p "$RELEASE_DIR/ios"

# ── Android: --split-debug-info output in build/debug-info/android ───────────
ANDROID_SRC="$BUILD_DIR/debug-info/android"
ANDROID_MOVED=0
if [ -d "$ANDROID_SRC" ]; then
  while IFS= read -r -d '' item; do
    echo "[android] moving: $item"
    mv "$item" "$RELEASE_DIR/android/"
    ANDROID_MOVED=1
  done < <(find "$ANDROID_SRC" -mindepth 1 -maxdepth 1 -print0 2>/dev/null)

  if [ "$ANDROID_MOVED" -eq 0 ]; then
    echo "[android] directory empty — skipping"
  fi
else
  echo "[android] build/debug-info/android not found — skipping"
fi

# ── iOS: --split-debug-info output in build/debug-info/ios ──────────────────
IOS_SRC="$BUILD_DIR/debug-info/ios"
IOS_MOVED=0
if [ -d "$IOS_SRC" ]; then
  while IFS= read -r -d '' item; do
    echo "[ios] moving: $item"
    mv "$item" "$RELEASE_DIR/ios/"
    IOS_MOVED=1
  done < <(find "$IOS_SRC" -mindepth 1 -maxdepth 1 -print0 2>/dev/null)

  if [ "$IOS_MOVED" -eq 0 ]; then
    echo "[ios] directory empty — skipping"
  fi
else
  echo "[ios] build/debug-info/ios not found — skipping"
fi

# ── Summary ──────────────────────────────────────────────────────────────────
echo "[archive_symbols] done → $RELEASE_DIR"
