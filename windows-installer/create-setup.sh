#!/bin/bash

wine ../wix/candle.exe -o build/iif-devenv-bundle.wixobj iif-devenv-bundle.wxs -ext WixBalExtension
wine ../wix/light.exe -o build/iif-devenv-setup.exe build/iif-devenv-bundle.wixobj -ext WixBalExtension
