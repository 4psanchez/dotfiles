#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT_FILE="$SCRIPT_DIR/vscode-extensions.txt"

code --list-extensions > "$OUTPUT_FILE"

echo "Exportadas $(wc -l < "$OUTPUT_FILE") extensiones."