#!/bin/bash
set -e
if [[ ! -e /dev/net/tun ]]; then
        echo "tun node does not exist. Generating it ..."
        (HERE=$(pwd) && cd /dev && MAKEDEV tun && cd ${HERE})
fi
# we need to fix permissions
sudo chmod 666 /dev/net/tun
