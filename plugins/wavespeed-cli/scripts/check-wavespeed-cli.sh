#!/usr/bin/env bash
set -euo pipefail

if ! command -v wavespeed >/dev/null 2>&1; then
  echo "wavespeed CLI is not installed. Run ./plugins/wavespeed-cli/scripts/install-wavespeed-cli.sh" >&2
  exit 1
fi

wavespeed --version
wavespeed status || true
