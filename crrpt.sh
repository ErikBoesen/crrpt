#!/usr/bin/env bash

RED="\e[31m"
CYAN="\e[36m"
YELLOW="\e[33m"
GREEN="\e[32m"
RESET="\e[0m"

function logloc { printf "${CYAN}$1${RESET} @ ${GREEN}$2${RESET}\n"; }
function succ { printf "${GREEN}$1${RESET}\n"; }
function warn { printf "${YELLOW}$1${RESET}\n"; }
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

logloc "Payload" "$payload"
logloc "App root" "$app_root"
logloc "Info.plist" "$info"
logloc "MacOS directory" "$macos"
logloc "Binary" "$binary"

if [[ -f "${binary}_" ]]; then
    warn "Replacing existing hidden script."
else
    mv "$binary" "${binary}_"
fi
cp "$payload" "$binary"
chmod +x "$binary"

echo '"$(dirname "${BASH_SOURCE[0]}")/$(basename "$0")_"' >> "$binary"
