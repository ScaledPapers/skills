---
name: scaledpapers
description: "Create uptime checks, a status page, incidents, and maintenance windows for a website or API. Use when the user asks to monitor a health URL, set up a status page, open an incident, or schedule maintenance with ScaledPapers."
---

# ScaledPapers

Follow the official setup at https://scaledpapers.com/agent-setup/prompt.md. The human guide is https://scaledpapers.com/docs/mcp. Listed on https://www.skills.sh/scaledpapers/skills/scaledpapers.

## Install

```bash
npx skills add ScaledPapers/skills --skill scaledpapers -a claude-code -a codex -g -y
```

## Connect

1. If `SP_API_KEY` is already set and starts with `sp_`, keep it. Otherwise ask once. An owner or admin creates the key at https://scaledpapers.com/app/api-keys.
2. Export it in the shell. Never write the raw key into a committed file, and never print it back.
3. Wire MCP for the agent you are (idempotent). From this skill folder:

```bash
bash scripts/wire-mcp.sh cursor   # or claude, codex, all
```

If the skill lives under `~/.agents/skills/scaledpapers`, you can run:

```bash
bash ~/.agents/skills/scaledpapers/scripts/wire-mcp.sh codex
```

4. Call `usage` before creating a check or a page. Stop when a cap is reached. A 401 means the key is missing or revoked. Ask for a new key. Do not create checks during this check.

claude.ai, Claude Desktop, and ChatGPT expect OAuth. Do not invent a connector, a stdio package, or an OAuth client.

## After it is connected

Watch the health URLs the user names. Create checks (HTTP, API, DNS, or TCP), a status page, incidents, and maintenance from the tools.

Maintenance tools default `notify_subscribers` to false. Email subscribers only when the user asks.

Team invites, billing, creating and revoking API keys, creating or deleting alert destinations, deleting an incident, and visitor subscribers stay in the console. A private-page password belongs on Page settings, not in the chat.
