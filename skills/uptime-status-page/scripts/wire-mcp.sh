#!/usr/bin/env bash
# Idempotently register https://api.scaledpapers.com/mcp for Cursor, Claude Code, or Codex.
# Requires SP_API_KEY in the environment when you use MCP tools, not when you run this script.
set -euo pipefail

MCP_URL="https://api.scaledpapers.com/mcp"

usage() {
  echo "Usage: $0 cursor|claude|codex|all" >&2
  exit 1
}

wire_codex() {
  local f="${HOME}/.codex/config.toml"
  mkdir -p "$(dirname "$f")"
  touch "$f"
  if grep -q '^\[mcp_servers\.scaledpapers\]' "$f" 2>/dev/null; then
    echo "Codex: [mcp_servers.scaledpapers] already in $f"
    return 0
  fi
  {
    echo ""
    echo "[mcp_servers.scaledpapers]"
    echo "url = \"${MCP_URL}\""
    echo 'bearer_token_env_var = "SP_API_KEY"'
  } >>"$f"
  echo "Codex: appended ScaledPapers MCP to $f"
}

wire_cursor() {
  python3 <<'PY'
import json
import os

path = os.path.expanduser("~/.cursor/mcp.json")
data = {"mcpServers": {}}
if os.path.isfile(path):
    with open(path, encoding="utf-8") as f:
        data = json.load(f)
servers = data.setdefault("mcpServers", {})
servers["scaledpapers"] = {
    "url": "https://api.scaledpapers.com/mcp",
    "headers": {"Authorization": "Bearer ${env:SP_API_KEY}"},
}
os.makedirs(os.path.dirname(path) or ".", exist_ok=True)
with open(path, "w", encoding="utf-8") as f:
    json.dump(data, f, indent=2)
    f.write("\n")
print(f"Cursor: wrote {path}")
PY
}

wire_claude() {
  if ! command -v claude >/dev/null 2>&1; then
    echo "Claude Code CLI not found. Run:" >&2
    echo "  claude mcp add --transport http scaledpapers ${MCP_URL} \\" >&2
    echo '    --header "Authorization: Bearer ${SP_API_KEY}"' >&2
    return 1
  fi
  if claude mcp add --transport http scaledpapers "$MCP_URL" \
    --header "Authorization: Bearer \${SP_API_KEY}" 2>/dev/null; then
    echo "Claude Code: registered scaledpapers MCP"
  else
    echo "Claude Code: scaledpapers MCP already registered or add failed (check claude mcp list)"
  fi
}

case "${1:-}" in
  codex) wire_codex ;;
  cursor) wire_cursor ;;
  claude) wire_claude ;;
  all)
    wire_codex
    wire_cursor
    wire_claude || true
    ;;
  *) usage ;;
esac
