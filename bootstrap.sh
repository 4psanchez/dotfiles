#!/usr/bin/env bash

set -euo pipefail

echo "📦 Actualizando repositorios..."
sudo apt update

echo "📦 Instalando paquetes base..."
sudo apt install -y \
    git \
    curl \
    wget \
    zsh \
    eza \
    bat \
    fzf \
    zoxide \
    htop \
    btop \
    unzip \
    ripgrep

echo
echo "✅ Paquetes base instalados correctamente."