#!/usr/bin/env bash

set -euo pipefail

echo "📦 Actualizando repositorios..."
sudo apt update

echo "📦 Instalando dependencias para añadir repositorios externos..."
sudo apt install -y ca-certificates curl gnupg

sudo install -m 0755 -d /etc/apt/keyrings

add_apt_repo() {
    local list_file="$1"
    local key_url="$2"
    local key_file="$3"
    local repo_line="$4"

    if [[ -f "$list_file" ]]; then
        echo "  Repo ya presente: $list_file"
        return
    fi

    curl -fsSL "$key_url" | sudo gpg --dearmor -o "$key_file"
    sudo chmod a+r "$key_file"
    echo "$repo_line" | sudo tee "$list_file" > /dev/null
    echo "  Añadido: $list_file"
}

echo
echo "📦 Añadiendo repositorio de Docker..."
add_apt_repo \
    "/etc/apt/sources.list.d/docker.list" \
    "https://download.docker.com/linux/ubuntu/gpg" \
    "/etc/apt/keyrings/docker.gpg" \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable"

echo
echo "📦 Añadiendo repositorio de Google Chrome..."
add_apt_repo \
    "/etc/apt/sources.list.d/google-chrome.list" \
    "https://dl.google.com/linux/linux_signing_key.pub" \
    "/etc/apt/keyrings/google-chrome.gpg" \
    "deb [arch=amd64 signed-by=/etc/apt/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main"

echo
echo "📦 Añadiendo repositorio de HashiCorp (Terraform)..."
add_apt_repo \
    "/etc/apt/sources.list.d/hashicorp.list" \
    "https://apt.releases.hashicorp.com/gpg" \
    "/etc/apt/keyrings/hashicorp.gpg" \
    "deb [signed-by=/etc/apt/keyrings/hashicorp.gpg] https://apt.releases.hashicorp.com $(. /etc/os-release && echo "$VERSION_CODENAME") main"

echo
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
    ripgrep \
    tmux \
    tree \
    zip \
    traceroute \
    shellcheck \
    npm \
    openvpn \
    terraform \
    google-chrome-stable \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

echo
echo "✅ Paquetes base instalados correctamente."
