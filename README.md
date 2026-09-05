# WaveSpeed plugin for Codex

A [Codex](https://developers.openai.com/codex) plugin that lets the agent generate and edit AI media — image, video, audio, 3D — on the [WaveSpeed](https://wavespeed.ai) platform.

It bundles two things:

- **MCP server** — [`@wavespeed/mcp`](https://github.com/WaveSpeedAI/mcp-server), started on demand with `npx`. Tools: `search_models`, `get_model_schema`, `get_price`, `upload_file`, `run_model`, `get_prediction`, `get_balance`.
- **Skill** — the find → inspect → run workflow on the open-source [`@wavespeed/cli`](https://github.com/WaveSpeedAI/wavespeed-cli): search the live catalog, read any model's input schema, run it, upload local files with the `@path` marker, and quote prices before spending credits.

## Install

Add this repository as a plugin marketplace, then install **WaveSpeed** from `/plugins`:

```bash
codex plugin marketplace add WaveSpeedAI/codex-plugin-wavespeed-cli
```

Pin a release instead of tracking `main`:

```bash
codex plugin marketplace add WaveSpeedAI/codex-plugin-wavespeed-cli --ref v0.1.2
```

Or, with the community CLI: `npx codex-marketplace add WaveSpeedAI/codex-plugin-wavespeed-cli --plugins`.

## Requirements

- Node.js ≥ 18 (`npx` runs the MCP server, nothing else to install)
- A WaveSpeed account. Either set `WAVESPEED_API_KEY`, or install the CLI (`npm install -g @wavespeed/cli`) and run `wavespeed login` once. One login covers both the MCP server and the CLI. Keys live at [wavespeed.ai/accesskey](https://wavespeed.ai/accesskey).

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

Recommended starting models: `bytedance/seedream-v5.0-pro` for images, `wavespeed-ai/minimax-h3/*` for video (cheap, open-weights, native audio), `bytedance/seedance-2.5/*` when you need the highest video quality. The agent browses everything else with `search_models` or `wavespeed models`.

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
