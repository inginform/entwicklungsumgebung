#!/bin/bash
set -e

# clear the MSYS MOTD
clear

# Let's start docker-machine
echo 'Verifying that docker-machine is installed ...'
docker-machine -v
echo

echo 'Creating new docker environment with docker-machine. This may take some minutes ...'
docker-machine create --driver virtualbox iif-devenv
