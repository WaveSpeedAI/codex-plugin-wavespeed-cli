# WaveSpeed CLI Codex Plugin

Codex plugin marketplace package for the WaveSpeed CLI.

The plugin teaches Codex how to use the `wavespeed` command line tool to search the live WaveSpeed model catalog, inspect model schemas, upload files, run AI image, video, audio, and 3D generation, and parse JSON outputs.

## Install

Add this repository as a Codex plugin marketplace:

```bash
codex plugin marketplace add WaveSpeedAI/codex-plugin-wavespeed-cli --ref main
```

Then open Codex and install **WaveSpeed CLI** from `/plugins`.

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
