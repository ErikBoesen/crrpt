#!/usr/bin/env bash

RED="\e[31m"
CYAN="\e[36m"
YELLOW="\e[33m"
GREEN="\e[32m"
RESET="\e[0m"

function succ { printf "${GREEN}$1${RESET}\n"; }
function fail {
    printf "${RED}$1${RESET}\n" >&2
    exit 1
}

if [[ $# -lt 2 ]]; then
    fail "Not enough arguments!"
fi

payload="$1"
app_root="$2"
info="$app_root/Contents/Info.plist"
macos="$app_root/Contents/MacOS"
binary="$macos/$(/usr/libexec/PlistBuddy "$info" -c "Print :CFBundleExecutable")"

echo "Payload @ $payload"
echo "App root @ $app_root"
echo "Info.plist @ $info"
echo "MacOS directory @ $macos"
echo "Binary @ $binary"

mv "$binary" "${binary}_"
cp "$payload" "$binary"
chmod +x "$binary"

echo '$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)/$(basename $0)_' >> "$binary"
