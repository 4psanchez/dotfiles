#!/usr/bin/env bash

code --list-extensions > vscode-extensions.txt

echo "Exportadas $(wc -l < vscode-extensions.txt) extensiones."
