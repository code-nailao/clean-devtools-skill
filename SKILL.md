---
name: clean-devtools
description: Clean up Chrome DevTools MCP helper processes started by Codex App on macOS. Use when Codex App or Chrome DevTools MCP leaves high-memory chrome-devtools-mcp processes, or when the user asks to release memory by cleaning DevTools/Codex browser helper processes.
---

# Clean DevTools

Clean Codex App Chrome DevTools MCP helper processes on macOS.

## Script Directory

Scripts live in `scripts/`. `{baseDir}` = this `SKILL.md` directory.

| Script | Purpose |
|--------|---------|
| `scripts/clean-devtools.sh` | Stop stale `chrome-devtools-mcp` processes |

## Usage

Prefer the bundled script instead of rewriting `pkill` commands:

```bash
bash {baseDir}/scripts/clean-devtools.sh
```

Preview matched processes without killing them:

```bash
bash {baseDir}/scripts/clean-devtools.sh --dry-run
```

## Behavior

- Match only the current user's processes.
- Send `TERM` first to allow graceful shutdown.
- Wait 1 second.
- Send `KILL` only to remaining matched processes.
- Expect active Chrome DevTools MCP sessions to be interrupted.
- Use regex patterns like `[c]hrome-devtools-mcp` so the cleanup command does not match itself.

## When Reporting Back

Briefly say which process patterns were checked and whether anything was killed. Do not over-explain `pkill` unless the user asks.

When helping a user install this skill, tell them to run `Force Reload Skills` from the Codex Command Menu (`⌘K` or `⌘⇧P`) and then test in a new conversation. Do not tell them to restart the whole Codex App unless reload does not work.
