# 🏠 dotfiles

Mis dotfiles personales: configuración de shell (Zsh + Oh My Zsh + Powerlevel10k), Git, VSCode y varias apps de escritorio (GNOME, Flameshot, htop...), gestionados mediante symlinks.

## 📋 Contenido

| Archivo/Carpeta | Descripción |
|---|---|
| `.zshrc` | Configuración de Zsh |
| `.p10k.zsh` | Configuración del tema Powerlevel10k |
| `.oh-my-zsh/custom` | Plugins/temas personalizados de Oh My Zsh (los plugins de terceros se clonan aparte, no se versionan aquí) |
| `.gitconfig` | Configuración global de Git |
| `.bashrc` / `.profile` | Configuración de Bash |
| `.ssh/config` | Configuración de cliente SSH (sin claves ni hosts sensibles) |
| `.config/Code/User` | Settings, keybindings y snippets de VSCode |
| `.config/flameshot` | Configuración de Flameshot |
| `.config/htop` | Configuración de htop |
| `.config/gtk-3.0`, `.config/tiling-assistant`, `.config/org.gnome.Ptyxis` | Configuración de escritorio GNOME |
| `bootstrap.sh` | Instala los paquetes base del sistema (apt) |
| `install.sh` | Crea los symlinks de los dotfiles y clona los plugins de Oh My Zsh |
| `cleandot.sh` | Limpia el repo de archivos de estado y detecta repos Git anidados |
| `exportExtensionesvsCode.sh` | Exporta las extensiones instaladas de VSCode a `vscode-extensions.txt` (en la misma carpeta que el script) |
| `installExtensionesvsCode.sh` | Instala extensiones de VSCode desde `vscode-extensions.txt` (en la misma carpeta que el script) |

## 🚀 Instalación en una máquina nueva

Requisitos previos: `git`, `zsh` y `curl` instalados. Si no los tienes, instálalos primero:

```bash
sudo apt update && sudo apt install -y git zsh curl
```

### 1. Clonar el repositorio

```bash
git clone https://github.com/<TU_USUARIO>/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 2. Instalar paquetes base del sistema

```bash
bash bootstrap.sh
```

Instala: `git`, `curl`, `wget`, `zsh`, `eza`, `bat`, `fzf`, `zoxide`, `htop`, `btop`, `unzip`, `ripgrep`.

### 3. Instalar Oh My Zsh (si no está instalado)

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
```

### 4. Enlazar los dotfiles

```bash
bash install.sh
```

Esto:
- Crea symlinks desde `~/dotfiles` hacia `$HOME` para cada archivo/carpeta de configuración.
- Hace backup automático (`archivo.bak.FECHA`) de cualquier archivo existente antes de sobrescribirlo.
- Clona (o actualiza) los plugins de Oh My Zsh: `zsh-autosuggestions`, `zsh-syntax-highlighting`, `fzf-tab` y el tema `powerlevel10k`.

### 5. Cambiar el shell por defecto a Zsh (si no lo está ya)

```bash
chsh -s $(which zsh)
```

Cierra sesión y vuelve a entrar (o reinicia la terminal) para que se aplique.

### 6. (Opcional) Instalar extensiones de VSCode

```bash
bash installExtensionesvsCode.sh
```

## 🔄 Mantenimiento

### Exportar extensiones de VSCode actuales

```bash
bash exportExtensionesvsCode.sh
```

Actualiza `vscode-extensions.txt` con las extensiones instaladas actualmente.

### Limpiar el repositorio

```bash
bash cleandot.sh
```

Elimina del control de versiones los archivos de estado (sesiones, cachés) y avisa si hay repositorios Git anidados sin excluir en `.gitignore`.

## ⚠️ Notas de seguridad

- Este repositorio **no incluye** claves SSH, historiales de shell, ni credenciales — están excluidos vía `.gitignore`.
- `.ssh/config` solo contiene alias de host, sin claves privadas.
- Antes de hacer público este repo, revisa que `.gitconfig` y `.ssh/config` no contengan datos que no quieras compartir (emails, IPs internas, nombres de servidores privados).

## 🖥️ Probado en

- Ubuntu / GNOME

## 📝 Changelog de mantenimiento

Cambios aplicados a los scripts originales para robustecerlos de cara a un uso público del repo:

- **`bootstrap.sh`**: se añadió el shebang (`#!/usr/bin/env bash`) y `set -euo pipefail`, de forma que el script se detiene si falla la instalación de algún paquete en lugar de continuar silenciosamente.
- **`install.sh`**: se añadió una sección que clona (o actualiza con `git pull`) los plugins de Oh My Zsh —`zsh-autosuggestions`, `zsh-syntax-highlighting`, `fzf-tab`— y el tema `powerlevel10k`, ya que estos dejaron de versionarse directamente en el repo (ver siguiente punto).
- **`.gitignore`**: se excluyeron las carpetas de plugins/tema de Oh My Zsh (`.oh-my-zsh/custom/plugins/*` y `.oh-my-zsh/custom/themes/powerlevel10k`), porque cada una contiene su propio repositorio Git anidado. Si se versionan tal cual, Git las trata como *gitlinks* rotos y al clonar en otra máquina esas carpetas aparecen vacías. También se excluyó `*.zwc` (bytecode compilado de Zsh, se regenera automáticamente y es específico de cada máquina).
- **`exportExtensionesvsCode.sh`** / **`installExtensionesvsCode.sh`**: antes asumían que `vscode-extensions.txt` estaba en el directorio actual desde el que se ejecutaba el script. Ahora ambos resuelven la ruta del propio script (`SCRIPT_DIR`), así que funcionan igual sin importar desde dónde se invoquen. `installExtensionesvsCode.sh` también comprueba que el archivo exista antes de intentar leerlo.

## 📄 Licencia

Uso personal. Siéntete libre de tomar lo que te sea útil.