#!/usr/bin/env bash

set -euo pipefail

DOTFILES="$HOME/dotfiles"

cd "$DOTFILES"

echo "==============================="
echo " Limpiando repositorio"
echo "==============================="

FILES=(
".config/org.gnome.Ptyxis/session.gvariant"
".config/tiling-assistant/tiledSessionRestore2.json"
".config/gtk-3.0/bookmarks"
)

echo
echo "Eliminando archivos de estado del repositorio..."

for f in "${FILES[@]}"; do
    if git ls-files --error-unmatch "$f" >/dev/null 2>&1; then
        git rm --cached "$f"
    fi
done

echo
echo "Actualizando .gitignore..."

touch .gitignore

add_ignore() {

    grep -qxF "$1" .gitignore || echo "$1" >> .gitignore

}

add_ignore ".config/org.gnome.Ptyxis/session.gvariant"
add_ignore ".config/tiling-assistant/tiledSessionRestore2.json"
add_ignore ".config/gtk-3.0/bookmarks"

echo
echo "Eliminando Oh My Zsh del repositorio..."

if [ -d ".oh-my-zsh" ]; then
    git rm -r --cached .oh-my-zsh || true
fi

echo
echo "Buscando repositorios Git anidados..."

find . -type d -name ".git" \
    ! -path "./.git" \
    -print

echo
echo "==============================="
echo "Repositorio limpio."
echo "==============================="

echo
echo "Ahora ejecuta:"
echo
echo "git status"
