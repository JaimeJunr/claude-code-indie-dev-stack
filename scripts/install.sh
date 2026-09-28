#!/usr/bin/env bash
# Checklist installer: pick which plugins of this marketplace to install.
# Usage: scripts/install.sh [--all]
set -euo pipefail
cd "$(dirname "$0")/.."
MKT=product-eng-stack
mapfile -t NAMES < <(python3 -c 'import json;[print(p["name"]+"\t"+p["description"]) for p in json.load(open(".claude-plugin/marketplace.json"))["plugins"]]' | cut -f1)
if [[ "${1:-}" == "--all" ]]; then
  CHOSEN=("${NAMES[@]}")
else
  ARGS=()
  while IFS=$'\t' read -r n d; do ARGS+=("$n" "${d:0:70}" OFF); done < <(python3 -c 'import json;[print(p["name"]+"\t"+p["description"]) for p in json.load(open(".claude-plugin/marketplace.json"))["plugins"]]')
  OUT=$(whiptail --title "product-eng-stack" --checklist "Space marks, Enter confirms" 20 90 ${#NAMES[@]} "${ARGS[@]}" 3>&1 1>&2 2>&3) || exit 0
  eval "CHOSEN=($OUT)"
fi
claude plugin marketplace add "$PWD" >/dev/null 2>&1 || true
for p in "${CHOSEN[@]}"; do claude plugin install "$p@$MKT"; done
