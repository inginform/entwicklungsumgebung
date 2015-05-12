#!/bin/sh

set -e

set -x
if [ -d "pakete" ]; then
	rm -r pakete
fi
mkdir pakete
cd pakete

(
	mkdir -p docker
	cd docker

	curl -fsSL -o docker.exe "https://${DOCKER_BUCKET}/builds/Windows/x86_64/docker-${DOCKER_VERSION}.exe"
)

(
	mkdir -p msysGit
	cd msysGit

	curl -fsSL -o Git.exe "https://github.com/msysgit/msysgit/releases/download/Git-${MSYSGIT_VERSION}/Git-${MSYSGIT_VERSION}.exe"
)

(
	mkdir -p VirtualBox
	cd VirtualBox

	# http://www.virtualbox.org/manual/ch02.html
	curl -fsSL -o virtualbox.exe "http://download.virtualbox.org/virtualbox/${VBOX_VERSION}/VirtualBox-${VBOX_VERSION}-${VBOX_REVISION}-Win.exe"

	wine virtualbox.exe -extract -silent -path .
	rm virtualbox.exe # not neeeded after extraction

	rm *x86.msi # not needed as we only install 64-bit
	mv *_amd64.msi VirtualBox_amd64.msi # remove version number
)
