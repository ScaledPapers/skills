# ScaledPapers skill

A website check is up when the HTTP status is below 500. An API check is up on 200 unless another code is set. DNS is up when the lookup succeeds. TCP is up when the connection succeeds, or when it fails if that was the expected outcome. The same workspace publishes a status page, opens incidents, and schedules maintenance. [ScaledPapers](https://scaledpapers.com).

The server is `https://api.scaledpapers.com/mcp`. It uses a workspace API key (`SP_API_KEY`), not OAuth. Create the key at https://scaledpapers.com/app/api-keys. Setup steps: https://scaledpapers.com/docs/mcp.

## Install the skill

```bash
npx skills add ScaledPapers/skills --skill uptime-status-page -a claude-code -a codex -g -y
```

Then wire MCP (reads `SP_API_KEY` from the environment when tools run):

```bash
bash ~/.agents/skills/uptime-status-page/scripts/wire-mcp.sh codex
```

Use `cursor`, `claude`, or `all` instead of `codex`. Catalog: https://www.skills.sh/scaledpapers/skills/uptime-status-page

## Cursor Marketplace

This repo is also a Cursor plugin. After you install it, set `SP_API_KEY` under Plugins → Configure. The plugin does not contain a key.

Local load, before the marketplace listing is approved:

```bash
mkdir -p ~/.cursor/plugins/local
ln -s "$(pwd)" ~/.cursor/plugins/local/scaledpapers
```

Reload Cursor and confirm the skill and MCP server under Customize.
