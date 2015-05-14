#!/bin/bash

wine ../wix/candle.exe iif-devenv-bundle.wxs -ext WixBalExtension
wine ../wix/light.exe iif-devenv-bundle.wixobj -ext WixBalExtension
