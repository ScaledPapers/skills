# ScaledPapers skill

[ScaledPapers](https://scaledpapers.com) monitors a website or API with uptime checks and a public status page. This skill lets a coding agent create those checks, open incidents, and schedule maintenance.

The server is `https://api.scaledpapers.com/mcp`. It uses a workspace API key (`SP_API_KEY`), not OAuth. Create the key at https://scaledpapers.com/app/api-keys. Setup steps: https://scaledpapers.com/docs/mcp.

## Install the skill

```bash
npx skills add ScaledPapers/skills --skill scaledpapers -a claude-code -a codex -g -y
```

Then wire MCP (reads `SP_API_KEY` from the environment when tools run):

```bash
bash ~/.agents/skills/scaledpapers/scripts/wire-mcp.sh codex
```

Use `cursor`, `claude`, or `all` instead of `codex`. Catalog: https://www.skills.sh/scaledpapers/skills/scaledpapers

## Cursor Marketplace

This repo is also a Cursor plugin. After you install it, set `SP_API_KEY` under Plugins → Configure. The plugin does not contain a key.

Local load, before the marketplace listing is approved:

```bash
mkdir -p ~/.cursor/plugins/local
ln -s "$(pwd)" ~/.cursor/plugins/local/scaledpapers
```

Reload Cursor and confirm the skill and MCP server under Customize.
