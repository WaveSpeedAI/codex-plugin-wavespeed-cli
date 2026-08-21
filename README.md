# WaveSpeed CLI Codex Plugin

Codex plugin marketplace package for the WaveSpeed CLI.

The plugin teaches Codex how to use the `wavespeed` command line tool to search the live WaveSpeed model catalog, inspect model schemas, upload files, run AI image, video, audio, and 3D generation, and parse JSON outputs.

## Install

Add this repository as a Codex plugin marketplace:

```bash
codex plugin marketplace add WaveSpeedAI/codex-plugin-wavespeed-cli --ref v0.1.0
```

Then open Codex and install **WaveSpeed CLI** from `/plugins`.

To track the latest version instead of a pinned release:

```bash
codex plugin marketplace add WaveSpeedAI/codex-plugin-wavespeed-cli --ref main
```

## Requirements

- Node.js 18+
- npm
- A WaveSpeed API key

The plugin includes helper scripts:

```bash
./plugins/wavespeed-cli/scripts/install-wavespeed-cli.sh
./plugins/wavespeed-cli/scripts/check-wavespeed-cli.sh
```

Use `wavespeed login` for local auth, or set `WAVESPEED_API_KEY` in the shell environment for CI and one-off runs.

Quick setup:

```bash
codex plugin marketplace add WaveSpeedAI/codex-plugin-wavespeed-cli --ref v0.1.0
npm install -g @wavespeed/cli
wavespeed login
```

## Layout

```text
.agents/plugins/marketplace.json
plugins/wavespeed-cli/.codex-plugin/plugin.json
plugins/wavespeed-cli/skills/wavespeed-cli/SKILL.md
```

## Test

```bash
wavespeed status
wavespeed models "nano banana"
wavespeed models --type text-to-video
wavespeed models --type text-to-audio
wavespeed run google/nano-banana-2/text-to-image -h
```

---

**[WaveSpeed AI](https://wavespeed.ai/)** — hosted inference for image, video, audio and 3D models.
Try it in the browser: **[Image generator](https://wavespeed.ai/image-generator)** · **[Video generator](https://wavespeed.ai/video-generator)**
