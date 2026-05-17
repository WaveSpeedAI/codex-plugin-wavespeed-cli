#!/usr/bin/env bash
set -euo pipefail

if ! command -v npm >/dev/null 2>&1; then
  echo "npm is required to install @wavespeed/cli. Install Node.js 18+ first." >&2
  exit 1
fi

npm install -g @wavespeed/cli
wavespeed --version
