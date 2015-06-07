#!/bin/bash

if [ ! -d "build" ]; then
	echo 'Kein build Verzeichnis vorhanden. Muss der Sammler noch laufen oder hast Du ein Volume vergessen?'
	exit 1
fi

wine ../wix/candle.exe -o build/iif-devenv-bundle.wixobj iif-devenv-bundle.wxs -ext WixBalExtension -ext WixUtilExtension
wine ../wix/light.exe -o build/iif-devenv-setup.exe build/iif-devenv-bundle.wixobj -ext WixBalExtension -ext WixUtilExtension
