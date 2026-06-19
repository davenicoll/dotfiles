#!/bin/bash
set -euo pipefail

GNOME_VER=$(gnome-shell --version | grep -oP '^\D*\K\d+')
BASE_URL="https://extensions.gnome.org"

install_extension() {
    local pk=$1
    local description=$2

    echo "Installing: $description (pk=$pk, GNOME $GNOME_VER)..."

    # Get extension info and extract UUID + version tag for our shell version
    local info
    info=$(curl -sf "$BASE_URL/extension-info/?pk=$pk&shell_version=$GNOME_VER")

    local uuid
    uuid=$(echo "$info" | python3 -c "import json,sys; print(json.load(sys.stdin)['uuid'])")

    local version_tag
    version_tag=$(echo "$info" | python3 -c "
import json,sys
data = json.load(sys.stdin)
vm = data.get('shell_version_map', {})
if '$GNOME_VER' in vm:
    print(vm['$GNOME_VER']['pk'])
else:
    print('NONE')
")

    if [ "$version_tag" = "NONE" ]; then
        echo "  ERROR: No compatible version for GNOME $GNOME_VER"
        return 1
    fi

    local zip="/tmp/${uuid}.zip"
    curl -sfL -o "$zip" "$BASE_URL/download-extension/${uuid}.shell-extension.zip?version_tag=${version_tag}"

    gnome-extensions install --force "$zip"
    gnome-extensions enable "$uuid" 2>/dev/null || true
    rm -f "$zip"

    echo "  Done: $uuid"
}

install_extension 779 "Clipboard Indicator"
install_extension 2 "Frippery Move Clock"

echo ""
echo "Extensions installed. Log out and back in (or restart GNOME Shell) to activate."
