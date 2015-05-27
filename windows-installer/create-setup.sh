#!/bin/bash

if [ ! -d "build" ]; then
	echo 'Kein build Verzeichnis vorhanden. Muss der Sammler noch laufen oder hast Du ein Volume vergessen?'
	exit 1
fi

# build MSI
wine ../wix/candle.exe -o build/iif-devenv.wixobj iif-devenv.wxs
wine ../wix/light.exe -o build/iif-devenv.msi -sval build/iif-devenv.wixobj

# test msi
wine msiexec /i build/iif-devenv.msi
