#!/bin/bash

apt-get update
apt-get install -y wiringpi
apt-get install -y udevil --no-install-recommends
apt-get install -y udisks udisks2 pmount eject
apt-get install -y nodejs nodejs-legacy npm
npm install -g npm
npm install -g n
npm install -g node-gyp
n lts

pushd /tmp/updater
w3d-server/install.sh
usb-configurator/install.sh
popd
