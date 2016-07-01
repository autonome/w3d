##!/bin/bash -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
mkdir -p /opt
cp -r $DIR/w3d-server /opt/
pushd /opt/w3d-server
npm install
popd
cp $DIR/w3d-server.service /etc/systemd/system/
ln -s /etc/systemd/system/w3d-server.service /etc/systemd/system/multi-user.target.wants/
cp $DIR/http.service /etc/avahi/services/
