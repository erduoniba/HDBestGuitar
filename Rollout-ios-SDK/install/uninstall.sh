#!/bin/bash

export PATH=/usr/bin:/bin:"$PATH"
BIN_DIR="$(cd "$(dirname "$0")" && pwd )"
BASE_DIR="$(dirname "$BIN_DIR")"
PROJECT_DIR=$(dirname "$BASE_DIR")

xcode_dir="$1"
[ -n "$xcode_dir" ] || { echo "expected xcode_dir argument" 1>&2; exit 1; }

"$BIN_DIR"/Installer -u "$xcode_dir"