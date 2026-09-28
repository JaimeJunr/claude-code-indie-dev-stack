#!/usr/bin/env bash
# Pulls plugins from anthropics/knowledge-work-plugins into plugins/, strips the
# MCP connector servers (.mcp.json) and regenerates the marketplace manifest.
# Usage: scripts/sync.sh [ref]   (default: main)
# To add a plugin, append its upstream folder name to PLUGINS.
set -euo pipefail
cd "$(dirname "$0")/.."
PLUGINS=(product-management engineering small-business legal design data)
REF="${1:-main}"
TMP="$(mktemp -d)"; trap 'rm -rf "$TMP"' EXIT
git clone --quiet --depth 1 --branch "$REF" https://github.com/anthropics/knowledge-work-plugins "$TMP/up"
COMMIT="$(git -C "$TMP/up" rev-parse HEAD)"
rm -rf plugins; mkdir plugins
for p in "${PLUGINS[@]}"; do
  cp -r "$TMP/up/$p" "plugins/$p"
  rm -f "plugins/$p/.mcp.json"
  cp "$TMP/up/LICENSE" "plugins/$p/LICENSE"
done
python3 - "${PLUGINS[@]}" <<'PY'
import json, sys
plugins = []
for p in sys.argv[1:]:
    m = json.load(open(f"plugins/{p}/.claude-plugin/plugin.json"))
    plugins.append({
        "name": p, "source": f"./plugins/{p}", "description": m["description"],
        "author": {"name": "Anthropic"}, "license": "Apache-2.0",
        "homepage": f"https://github.com/anthropics/knowledge-work-plugins/tree/main/{p}",
    })
json.dump({
    "$schema": "https://anthropic.com/claude-code/marketplace.schema.json",
    "name": "indie-dev-stack",
    "owner": {"name": "Jaime Basso", "url": "https://github.com/JaimeJunr"},
    "metadata": {"description": "The Claude Code stack for indie developers with their own projects and products: Anthropic's knowledge-work plugins, each optional, without the MCP connectors: no logins, just skills."},
    "plugins": plugins,
}, open(".claude-plugin/marketplace.json", "w"), indent=2, ensure_ascii=False)
open(".claude-plugin/marketplace.json", "a").write("\n")
PY
printf '{\n  "repo": "anthropics/knowledge-work-plugins",\n  "ref": "%s",\n  "commit": "%s",\n  "synced_at": "%s"\n}\n' \
  "$REF" "$COMMIT" "$(date +%F)" > UPSTREAM.lock
echo "synced @ ${COMMIT:0:7}"
