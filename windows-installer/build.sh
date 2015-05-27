#!/bin/bash

call_sammler() {
	docker run --rm -it -v $(pwd)/build:/data inginform/devenv-sammler-windows
}

build_bundle() {
	docker run --rm -it -v $(pwd):/home/xclient/wix-project -w /home/xclient/wix-project suchja/wix ./create-bundle.sh
}

build_setup() {
	docker-compose run Wix ./create-setup.sh
}

if [ ! -d "build" ]; then
	mkdir -p build
fi

if [ "$1" == "all" ]; then
	call_sammler
	build_bundle
elif [ "$1" == "setup" ]; then
	build_setup
elif [ "$1" == "bundle" ]; then
	build_bundle
else
	echo 'Das Target ist nicht unterstützt. Verwende all, bundle oder setup als Parameter!'
fi
