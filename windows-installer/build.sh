#!/bin/bash

call_sammler() {
	docker run --rm -it -v $(pwd)/build:/data inginform/devenv-sammler-windows
}

build_setup() {
	docker run --rm -it -v $(pwd):/home/xclient/wix-project -w /home/xclient/wix-project suchja/wix ./create-setup.sh
}

if [ ! -d "build" ]; then
	mkdir -p build
fi

if [ "$1" == "all" ]; then
	call_sammler
	build_setup
elif [ "$1" == "setup" ]; then
	build_setup
else
	echo 'Das Target ist nicht unterstützt. Verwende all oder setup als Parameter!'
fi
