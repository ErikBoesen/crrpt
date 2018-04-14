#!/usr/bin/env bash

app_root="$1"
macos="$app_root/Contents/MacOS"
binary="$macos/$(/usr/libexec/PlistBuddy "$info" -c "Print :CFBundleExecutable")"

mv "${binary}_" "$binary"
