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
	mkdir -p boot2docker
	cd boot2docker

	curl -fsSL -o boot2docker.iso "https://github.com/boot2docker/boot2docker/releases/download/v${BOOT2DOCKER_VERSION}/boot2docker.iso"
)

(
	mkdir -p docker-machine
	cd docker-machine

	curl -fsSL -o docker-machine.exe "https://github.com/docker/machine/releases/download/v${DOCKER_MACHINE_VERSION}/docker-machine_windows-amd64.exe"
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
