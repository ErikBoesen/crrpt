#!/usr/bin/env bash

app_root="$1"
info="$app_root/Contents/Info.plist"
macos="$app_root/Contents/MacOS"
binary="$macos/$(/usr/libexec/PlistBuddy "$info" -c "Print :CFBundleExecutable")"

mv "${binary}_" "$binary"
