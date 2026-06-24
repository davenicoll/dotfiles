#!/bin/bash

# pre-accept the ttf-mscorefonts-installer eula
echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections
echo ttf-mscorefonts-installer msttcorefonts/present-mscorefonts-eula note | sudo debconf-set-selections

sudo apt install nano libssl-dev fonts-noto-core curl figlet lolcat wget eza git neofetch xclip nmap htop shellcheck obs-studio p7zip-full unzip file build-essential silversearcher-ag fzf jq ffmpeg gnome-shell-extension-prefs ttf-mscorefonts-installer zlib1g-dev libreadline-dev libreadline8 sqlite3 libsqlite3-dev libbz2-dev -y -qq
fc-cache -fv

# gitleaks (no apt package; install latest release binary from GitHub into ~/.local/bin)
if ! command -v gitleaks >/dev/null 2>&1; then
  GITLEAKS_VERSION="$(curl -fsSL https://api.github.com/repos/gitleaks/gitleaks/releases/latest | jq -r .tag_name | sed 's/^v//')"
  case "$(dpkg --print-architecture)" in
    amd64) GL_ARCH=x64 ;;
    arm64) GL_ARCH=arm64 ;;
    *) GL_ARCH="$(dpkg --print-architecture)" ;;
  esac
  mkdir -p "$HOME/.local/bin"
  curl -fsSL "https://github.com/gitleaks/gitleaks/releases/download/v${GITLEAKS_VERSION}/gitleaks_${GITLEAKS_VERSION}_linux_${GL_ARCH}.tar.gz" \
    | tar -xz -C "$HOME/.local/bin" gitleaks
  chmod +x "$HOME/.local/bin/gitleaks"
fi