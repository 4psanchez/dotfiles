#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
EXT_FILE="$SCRIPT_DIR/vscode-extensions.txt"

if [[ ! -f "$EXT_FILE" ]]; then
    echo "❌ No existe $EXT_FILE. Ejecuta antes exportExtensionesvsCode.sh (en otra máquina) o crea el archivo manualmente."
    exit 1
fi

while read -r extension
do
    code --install-extension "$extension"
done < "$EXT_FILE"

echo "✅ Extensiones instaladas desde $EXT_FILE."