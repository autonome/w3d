##!/bin/bash -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
mkdir -p /opt/usb-configurator
cp -r $DIR/setup.py /opt/usb-configurator/
cp $DIR/usb-configurator.service /etc/systemd/system/
ln -s /etc/systemd/system/usb-configurator.service /etc/systemd/system/multi-user.target.wants/
