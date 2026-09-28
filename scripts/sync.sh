#!/usr/bin/env bash
# Pulls plugins from anthropics/knowledge-work-plugins into plugins/, strips the
# MCP connector servers (.mcp.json) and regenerates the marketplace manifest.
# Usage: scripts/sync.sh [ref]   (default: main)
# plugins/indie-dev-stack is ours (the glue) and is never touched here.
# patches/descriptions.json appends a routing hint to a skill's description.
# To add a plugin, append its upstream folder name to PLUGINS.
set -euo pipefail
cd "$(dirname "$0")/.."
PLUGINS=(product-management engineering small-business design data)
REF="${1:-main}"
TMP="$(mktemp -d)"; trap 'rm -rf "$TMP"' EXIT
git clone --quiet --depth 1 --branch "$REF" https://github.com/anthropics/knowledge-work-plugins "$TMP/up"
COMMIT="$(git -C "$TMP/up" rev-parse HEAD)"
mkdir -p plugins
for p in "${PLUGINS[@]}"; do
  rm -rf "plugins/$p"
  cp -r "$TMP/up/$p" "plugins/$p"
  rm -f "plugins/$p/.mcp.json"
  cp "$TMP/up/LICENSE" "plugins/$p/LICENSE"
done
python3 - "${PLUGINS[@]}" <<'PY'
import json, re, sys
from pathlib import Path

def patch(skill_md, suffix):
    text = skill_md.read_text()
    m = re.match(r"---\n(.*?)\n---\n", text, re.S)
    if not m: sys.exit(f"patch: no frontmatter in {skill_md}")
    fm = m.group(1).split("\n")
    i = next((k for k, l in enumerate(fm) if l.startswith("description:")), None)
    if i is None: sys.exit(f"patch: no description in {skill_md}")
    j = i + 1
    while j < len(fm) and (fm[j].startswith(" ") or fm[j].startswith("\t")): j += 1
    val = fm[i].split(":", 1)[1].strip()
    if val in (">", ">-", "|", "|-", ""):
        val = " ".join(l.strip() for l in fm[i + 1:j])
    val = val.strip().strip('"')
    new = (val + " " + suffix).replace("\\", "\\\\").replace('"', '\\"')
    fm[i:j] = [f'description: "{new}"']
    skill_md.write_text("---\n" + "\n".join(fm) + "\n---\n" + text[m.end():])

patched = []
for key, suffix in json.load(open("patches/descriptions.json")).items():
    plugin, skill = key.split("/")
    f = Path(f"plugins/{plugin}/skills/{skill}/SKILL.md")
    if not f.exists(): sys.exit(f"patch target missing: {f}")
    patch(f, suffix); patched.append(key)
Path("patches/.applied").write_text("\n".join(patched) + "\n")

plugins = [{
    "name": "indie-dev-stack", "source": "./plugins/indie-dev-stack",
    "description": json.load(open("plugins/indie-dev-stack/.claude-plugin/plugin.json"))["description"],
    "author": {"name": "Jaime Basso", "url": "https://github.com/JaimeJunr"},
    "license": "MIT", "homepage": "https://github.com/JaimeJunr/claude-code-indie-dev-stack",
}]
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
    "metadata": {"description": "The Claude Code stack for indie developers with their own projects and products: Anthropic's knowledge-work plugins, each optional, without the MCP connectors, plus a glue plugin that routes between them."},
    "plugins": plugins,
}, open(".claude-plugin/marketplace.json", "w"), indent=2, ensure_ascii=False)
open(".claude-plugin/marketplace.json", "a").write("\n")
PY
rm -f patches/.applied
printf '{\n  "repo": "anthropics/knowledge-work-plugins",\n  "ref": "%s",\n  "commit": "%s",\n  "synced_at": "%s"\n}\n' \
  "$REF" "$COMMIT" "$(date +%F)" > UPSTREAM.lock
echo "synced @ ${COMMIT:0:7}"
