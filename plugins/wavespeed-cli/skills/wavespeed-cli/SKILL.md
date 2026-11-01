---
name: wavespeed-cli
description: Generate, edit, animate, upscale, or transform AI media using the WaveSpeed CLI from Codex. Use when the user asks to create image, video, audio, 3D, TTS, marketing creatives, or to inspect/run WaveSpeed models.
---

# WaveSpeed CLI

Use the `wavespeed` CLI to run WaveSpeed image, video, audio, and 3D models: the shortcuts for plain images and videos, and the generic run for every other model.

This plugin also starts the WaveSpeed MCP server. Its tools map one-to-one onto the CLI commands below: `list_models` = `wavespeed models`, `get_model_schema` = `wavespeed schema`, `get_price` = `wavespeed price`, `upload_file` = `wavespeed upload`, `run_model` = `wavespeed run`, `generate_image` / `edit_image` / `generate_video` / `edit_video` / `extend_video` = `wavespeed generate|edit|extend`, `get_prediction` = `wavespeed show`, `get_balance` = `wavespeed balance`. Prefer the MCP tools for single generations; use the CLI when it is installed and the user wants batch or scripted runs. Both share the same login.

## Before Running

Check whether the CLI is available:

```bash
wavespeed --version
```

If it is missing, run this plugin helper:

```bash
./plugins/wavespeed-cli/scripts/install-wavespeed-cli.sh
```

Check auth before generation:

```bash
wavespeed status
```

If the user is not signed in, ask them to run `wavespeed login`. Do not ask the user to paste an API key into chat. For CI or one-off shells, `WAVESPEED_API_KEY` may be set in the environment.

## Images and videos: the shortcuts

| Task | CLI | MCP tool |
|---|---|---|
| Image from a prompt (optionally with reference pictures) | `wavespeed generate image "<prompt>" [--image @./ref.jpg]` | `generate_image` |
| Edit, restyle, combine images | `wavespeed edit image "<prompt>" --image @./photo.jpg` | `edit_image` |
| Video from a prompt, a first/last frame, or references | `wavespeed generate video "<prompt>" [--first-frame …] [--ref-image …]` | `generate_video` |
| Edit a video | `wavespeed edit video "<prompt>" --video @./clip.mp4` | `edit_video` |
| Continue a video | `wavespeed extend video "<prompt>" --video @./clip.mp4` | `extend_video` |

They use the same models as the WaveSpeed /chat page and pick the endpoint (text, image, reference, edit) from the inputs you give. In the prompt, refer to media as `@image 1`, `@video 1`, `@audio 1`, in the order given ("put the product in @image 1 into the kitchen in @image 2").

- **Price first for videos:** CLI `--estimate --json`, MCP `estimate_only: true`. It returns the endpoint, the exact request and the price, and submits nothing.
- **Models:** pass `-m` / `model` only when the user names one; a named model is never switched. Without it the default is used, or another model only when the default cannot take the inputs.
- **Options:** `--aspect-ratio`, `--resolution`, `--duration` (CLI) or the same fields (MCP). Set them only when the user asks; values are snapped to what the model supports, and every change is reported.
- CLI: add `--json` to read the result, `--download` to save files.

### Default models

| | Default | Alternatives (`-m` / `model`) |
|---|---|---|
| Image | `seedream-5-pro` (Seedream 5 Pro) | `gpt-image-2.5` (GPT Image 2.5, the model behind ChatGPT Images; strong at text and photorealism), `nano-banana-2.1`, `nano-banana-pro`, `nano-banana-2`, `gpt-image-2` |
| Video | `seedance-2.5` (Seedance 2.5) | `seedance-2.5-turbo`, `kling-4.0`, `wan-3.0`, `wan-3.0-prime`, `minimax-h3` (cheap and fast, native stereo audio; defaults to 768p, its counterpart of 720p), older Seedance 2.0 tiers |

Video resolution is 720p unless the user asks for another (MiniMax H3: 768p). Offer 480p for a cheaper draft.

## Everything else: the generic run

Every model on the platform is one `wavespeed run <model-id>` (MCP: `run_model`). The model id is always explicit.

```bash
# 1. FIND a model in the live catalog (MCP: list_models)
wavespeed models "upscale"
wavespeed models --type text-to-audio --popular

# 2. INSPECT its inputs (MCP: get_model_schema)
wavespeed run <model-id> -h

# 3. RUN it, with --json so you can read the result (MCP: run_model)
wavespeed run <model-id> -p "..." -i key=value --json
```

`run --json` returns `{ id, model, prompt, outputs: [url, ...], saved: [path, ...], elapsed_ms, raw }`. Keep `id`: it is the handle for `wavespeed show <id>` (MCP: `get_prediction`) if anything is interrupted. Use the URL when the user wants a link; add `--download` when they need the file on disk.

```bash
# Local files: @path uploads the file and passes its URL
wavespeed run <model-id> -i image=@./photo.jpg --json
wavespeed run <model-id> -i images='["@./a.jpg","@./b.jpg"]' --json

# Or upload separately when you need the URL itself (MCP: upload_file / create_upload)
URL=$(wavespeed upload ./photo.jpg --json | jq -r .url)

# Save outputs with a template
wavespeed run <model-id> -p "..." --download "./out/{index}.{ext}"
```

The generic run never changes the user's prompt or inputs. The single exception is explicit: an `@path` value uploads that file and substitutes its hosted URL. Bare paths are never uploaded.

## Project config and aliases

If `wavespeed.json` exists (created by `wavespeed init`):

- **`defaultModel`** lets `wavespeed run -p "…"` (no model arg) work.
- **Aliases** are named shortcuts that bundle model + default inputs. Run `wavespeed aliases` to see them; `wavespeed run <alias> -h` shows the resolved schema. CLI `-i k=v` overrides alias defaults.


## Cost and credits

- `wavespeed price <id> -i k=v --json` (MCP: `get_price`) estimates a run without generating or charging. The shortcuts have `--estimate` / `estimate_only`.
- `wavespeed balance` (MCP: `get_balance`) shows the remaining credit; `wavespeed usage` and `wavespeed billings` show what was spent.
- If a run fails with `Insufficient credits` (or says a top-up is required), the balance is too low: do not retry. Tell the user and give them https://wavespeed.ai/top-up. You cannot pay for them.

## Pitfalls

- Don't invent model IDs. Confirm with `wavespeed models` or `wavespeed schema <id>` (MCP: `list_models`, `get_model_schema`) before a generic run.
- Local files: use `@./file.jpg`. Bare paths are NOT uploaded and the model will reject them. The hosted MCP server cannot read local files at all.
- `wavespeed delete` requires `--yes` when run non-interactively (that includes you).
- A run that fails with a gateway or network error (502/503/504, connection reset, timeout) does NOT mean the task failed, and the submit request is never retried automatically, so re-running can create a duplicate paid task. Do not re-run immediately. If the error contains a task id (`task_id` / prediction id), keep checking it with `wavespeed show <id> --json` (MCP: `get_prediction`) until its status is terminal (`completed`, `failed`, `cancelled`, `timeout`, `deleted`). If no id was returned, check recent predictions with `wavespeed history --json` (MCP: `list_predictions`; add the model; default window is the last 24h) and re-run once only if none matches. A client-side wait timeout or an interrupted run does not mean the task failed: tasks can run for a long time, so do not give up after a fixed time.
