#!/usr/bin/env bash

set -euo pipefail

DOTFILES="$HOME/dotfiles"

echo "📂 Repositorio: $DOTFILES"

mkdir -p "$DOTFILES"

backup() {
    local file="$1"

    if [[ -e "$file" && ! -L "$file" ]]; then
        mv "$file" "$file.bak.$(date +%Y%m%d-%H%M%S)"
        echo "  Backup -> $file"
    fi
}

link_file() {
    local source="$1"
    local target="$2"

    mkdir -p "$(dirname "$source")"
    mkdir -p "$(dirname "$target")"

    if [[ ! -e "$source" ]]; then
        if [[ -e "$target" ]]; then
            mv "$target" "$source"
            echo "  Movido: $target -> $source"
        else
            echo "  No existe: $target"
            return
        fi
    fi

    backup "$target"

    ln -sfn "$source" "$target"

    echo "  Enlace: $target -> $source"
}

#########################################
# HOME
#########################################

link_file "$DOTFILES/.zshrc" "$HOME/.zshrc"
link_file "$DOTFILES/.p10k.zsh" "$HOME/.p10k.zsh"
link_file "$DOTFILES/.gitconfig" "$HOME/.gitconfig"
link_file "$DOTFILES/.bashrc" "$HOME/.bashrc"
link_file "$DOTFILES/.profile" "$HOME/.profile"

#########################################
# SSH
#########################################

mkdir -p "$DOTFILES/.ssh"

link_file "$DOTFILES/.ssh/config" "$HOME/.ssh/config"

#########################################
# Oh My Zsh
#########################################
# NOTA: NO enlazamos "custom" completo. Oh My Zsh gestiona con git su propio
# repo y espera que "custom/" sea un directorio real (contiene su
# "example.zsh" de fábrica). Si "custom" es un symlink, "omz update" falla
# con "beyond a symbolic link" al hacer autostash.
#
# En su lugar, enlazamos solo las subcarpetas que nosotros personalizamos
# (plugins y tema), dejando el resto de "custom/" intacto.

clone_or_pull() {
    local repo="$1"
    local dest="$2"

    if [[ -d "$dest/.git" ]]; then
        echo "  Actualizando: $dest"
        git -C "$dest" pull --quiet
    else
        echo "  Clonando: $repo -> $dest"
        git clone --quiet --depth=1 "$repo" "$dest"
    fi
}

mkdir -p "$HOME/.oh-my-zsh/custom/plugins"
mkdir -p "$HOME/.oh-my-zsh/custom/themes"

mkdir -p "$DOTFILES/.oh-my-zsh/custom/plugins"
mkdir -p "$DOTFILES/.oh-my-zsh/custom/themes"

clone_or_pull \
"https://github.com/Aloxaf/fzf-tab" \
"$DOTFILES/.oh-my-zsh/custom/plugins/fzf-tab"

clone_or_pull \
"https://github.com/zsh-users/zsh-autosuggestions" \
"$DOTFILES/.oh-my-zsh/custom/plugins/zsh-autosuggestions"

clone_or_pull \
"https://github.com/zsh-users/zsh-syntax-highlighting" \
"$DOTFILES/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"

clone_or_pull \
"https://github.com/romkatv/powerlevel10k" \
"$DOTFILES/.oh-my-zsh/custom/themes/powerlevel10k"

link_file \
"$DOTFILES/.oh-my-zsh/custom/plugins/fzf-tab" \
"$HOME/.oh-my-zsh/custom/plugins/fzf-tab"

link_file \
"$DOTFILES/.oh-my-zsh/custom/plugins/zsh-autosuggestions" \
"$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"

link_file \
"$DOTFILES/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" \
"$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"

link_file \
"$DOTFILES/.oh-my-zsh/custom/themes/powerlevel10k" \
"$HOME/.oh-my-zsh/custom/themes/powerlevel10k"

#########################################
# CONFIG
#########################################

mkdir -p "$DOTFILES/.config"

link_file \
"$DOTFILES/.config/flameshot" \
"$HOME/.config/flameshot"

link_file \
"$DOTFILES/.config/gtk-3.0" \
"$HOME/.config/gtk-3.0"

link_file \
"$DOTFILES/.config/htop" \
"$HOME/.config/htop"

link_file \
"$DOTFILES/.config/org.gnome.Ptyxis" \
"$HOME/.config/org.gnome.Ptyxis"

link_file \
"$DOTFILES/.config/tiling-assistant" \
"$HOME/.config/tiling-assistant"

link_file \
"$DOTFILES/.config/mimeapps.list" \
"$HOME/.config/mimeapps.list"

#########################################
# VSCode
#########################################

mkdir -p "$DOTFILES/.config/Code/User"

link_file \
"$DOTFILES/.config/Code/User/settings.json" \
"$HOME/.config/Code/User/settings.json"

link_file \
"$DOTFILES/.config/Code/User/keybindings.json" \
"$HOME/.config/Code/User/keybindings.json"

link_file \
"$DOTFILES/.config/Code/User/snippets" \
"$HOME/.config/Code/User/snippets"

echo
echo "✅ Dotfiles instalados correctamente."