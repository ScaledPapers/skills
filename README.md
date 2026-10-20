# ScaledPapers skill

Connect a coding agent to [ScaledPapers](https://scaledpapers.com) so it can create checks, a status page, incidents, and maintenance windows.

The server is `https://api.scaledpapers.com/mcp`. It uses a workspace API key (`SP_API_KEY`), not OAuth. Create the key at https://scaledpapers.com/app/api-keys. Setup steps: https://scaledpapers.com/docs/mcp.

## Install the skill

```bash
npx skills add ScaledPapers/skills --skill scaledpapers -a claude-code -a codex
```

## Cursor Marketplace

This repo is also a Cursor plugin. After you install it, set `SP_API_KEY` under Plugins → Configure. The plugin does not contain a key.

Local load, before the marketplace listing is approved:

```bash
mkdir -p ~/.cursor/plugins/local
ln -s "$(pwd)" ~/.cursor/plugins/local/scaledpapers
```

Reload Cursor and confirm the skill and MCP server under Customize.
