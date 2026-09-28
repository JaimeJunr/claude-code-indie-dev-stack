#!/usr/bin/env bash
# Pulls product-management and engineering from anthropics/knowledge-work-plugins,
# copies them into plugins/ and strips the MCP connector servers (.mcp.json).
# Usage: scripts/sync.sh [ref]   (default: main)
set -euo pipefail
cd "$(dirname "$0")/.."
REF="${1:-main}"
TMP="$(mktemp -d)"; trap 'rm -rf "$TMP"' EXIT
git clone --quiet --depth 1 --branch "$REF" https://github.com/anthropics/knowledge-work-plugins "$TMP/up"
COMMIT="$(git -C "$TMP/up" rev-parse HEAD)"
for p in product-management engineering; do
  rm -rf "plugins/$p"
  cp -r "$TMP/up/$p" "plugins/$p"
  rm -f "plugins/$p/.mcp.json"
  cp "$TMP/up/LICENSE" "plugins/$p/LICENSE"
done
printf '{\n  "repo": "anthropics/knowledge-work-plugins",\n  "ref": "%s",\n  "commit": "%s",\n  "synced_at": "%s"\n}\n' \
  "$REF" "$COMMIT" "$(date +%F)" > UPSTREAM.lock
echo "synced @ ${COMMIT:0:7}"
