#!/bin/bash
set -e

# clear the MSYS MOTD
clear

# copy boot2docker.iso, if required
ISO="$HOME/.docker/machine/cache/boot2docker.iso"

if [ ! -e "$ISO" ]; then
	echo 'not sure how to update ISO'
	mkdir -p "$(dirname "$ISO")"
	cp ./boot2docker.iso "$ISO"
fi

# Let's start docker-machine
echo 'Verifying that docker-machine is installed ...'
docker-machine -v
echo

echo 'Creating new docker environment with docker-machine. This may take some minutes ...'
docker-machine create --driver virtualbox iif-devenv

echo 'Set environment variables for Docker'
eval "$(docker-machine env iif-devenv)"

echo 'Done! IIF DevEnv is up and running'
