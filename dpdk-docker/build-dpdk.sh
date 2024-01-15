#!/bin/bash

if [ "$(id -u)" != "0" ]; then
        echo "Sorry, you are not root."
        exit 1
fi

if [ "$DPDK_DIR" == "" ]; then
	echo "Sorry, DPDK_DIR has not been defined."
	exit 1
fi

if [ "$DPDK_BUILD" == "" ]; then
	echo "Sorry, DPDK_BUILD has not been defined."
	exit 1
fi

apt-get install linux-headers-$(uname -r)

cd "$DPDK_DIR"
echo "Building the $DPDK_BUILD flavor of DPDK in the $DPDK_DIR/$DPDK_BUILD directory"
meson setup build
cd build
ninja
meson install
ldconfig
