# WaveSpeed plugin for Codex

A [Codex](https://developers.openai.com/codex) plugin that lets the agent generate and edit AI media — image, video, audio, 3D — on the [WaveSpeed](https://wavespeed.ai) platform.

It bundles two things:

- **Hosted MCP server** — `https://api.wavespeed.ai/mcp`, authorized once in the browser. Generate, edit and extend images and videos, run any model, inspect schemas, and check prices and balance. The hosted server cannot read files on your computer; pass public URLs or use the CLI for local files.
- **Skill** — the find → inspect → run workflow on the open-source [`@wavespeed/cli`](https://github.com/WaveSpeedAI/wavespeed-cli): search the live catalog, read any model's input schema, run it, upload local files with the `@path` marker, and quote prices before spending credits.

## Install

Add this repository as a plugin marketplace, then install **WaveSpeed** from `/plugins`:

```bash
codex plugin marketplace add WaveSpeedAI/codex-plugins
```

Pin a release instead of tracking `main`:

```bash
codex plugin marketplace add WaveSpeedAI/codex-plugins --ref v0.1.4
```

Or, with the community CLI: `npx codex-marketplace add WaveSpeedAI/codex-plugins --plugins`.

## Requirements

- A WaveSpeed account. Approve the hosted MCP connection in the browser when Codex prompts you. You can revoke the resulting `MCP · …` API key on [API Keys](https://wavespeed.ai/accesskey).
- For local files, batches or scripts, install the CLI (`npm install -g @wavespeed/cli`) and run `wavespeed login`. CLI authentication is separate from the hosted MCP connection. The npm install path requires Node.js ≥ 18.

Helper scripts, if you prefer the CLI path:

```bash
./plugins/wavespeed-cli/scripts/install-wavespeed-cli.sh
./plugins/wavespeed-cli/scripts/check-wavespeed-cli.sh
```

## What the agent can do with it

- *"Generate a 16:9 hero image of a cyberpunk skyline at golden hour."*
- *"Animate ./hero.jpg into a 5-second clip with subtle parallax."*
- *"Replace the background of ./product.png with a sunlit kitchen."*
- *"How much would a 10-second 1080p video cost before you run it?"*

Recommended starting models: Seedream 5 Pro for images and Seedance 2.5 for video (the defaults of `wavespeed generate|edit|extend` and of the MCP `generate_image` / `generate_video` tools), with GPT Image 2.5, Nano Banana 2.1, Kling 4.0, Wan 3.0 and MiniMax H3 (cheap, native audio, 768p) as alternatives. The agent browses everything else with `list_models` or `wavespeed models`.

## Skill only, no plugin

Codex discovers skills in `.agents/skills/`. The CLI writes the same skill there:

```bash
npm install -g @wavespeed/cli
wavespeed skill install
```

## Layout

```text
.agents/plugins/marketplace.json
plugins/wavespeed-cli/.codex-plugin/plugin.json
plugins/wavespeed-cli/.mcp.json
plugins/wavespeed-cli/skills/wavespeed-cli/SKILL.md
plugins/wavespeed-cli/scripts/
```

## Same skill, other agents

- Claude Code: [WaveSpeedAI/claude-plugins](https://github.com/WaveSpeedAI/claude-plugins)
- Kimi Code CLI: [WaveSpeedAI/wavespeed-kimi-plugin](https://github.com/WaveSpeedAI/wavespeed-kimi-plugin)
- Gemini CLI: [WaveSpeedAI/wavespeed-gemini-extension](https://github.com/WaveSpeedAI/wavespeed-gemini-extension)
- DeepSeek Harness: [WaveSpeedAI/wavespeed-dsh-skill](https://github.com/WaveSpeedAI/wavespeed-dsh-skill)

## Security

See [SECURITY.md](SECURITY.md). The plugin stores no secrets; the skill never asks the user to paste a key into the chat.

## License

[MIT](LICENSE) — same as the CLI and the MCP server.

---

**[WaveSpeedAI](https://wavespeed.ai/)** — AI image & video generation platform.
Try it in the browser: **[Image generator](https://wavespeed.ai/image-generator)** · **[Video generator](https://wavespeed.ai/video-generator)**
