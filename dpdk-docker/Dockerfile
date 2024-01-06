FROM ubuntu:22.04
COPY ./dpdk-stable-22.11.3 /root/dpdk
COPY ./build-dpdk.sh /root/
WORKDIR /root/
RUN apt-get update && apt-get install -y build-essential automake python3-pip libcap-ng-dev gawk pciutils nano kmod libnuma-dev linux-headers-$(uname -r) lua5.3 liblua5.3-dev libpcap-dev meson ninja-build
RUN pip3 install pyelftools
ENV DPDK_DIR "/root/dpdk"
ENV DPDK_BUILD "x86_64-native-linuxapp-gcc"
ENV RTE_SDK "/root/dpdk"
ENV RTE_TARGET "x86_64-native-linuxapp-gcc"
RUN ./build-dpdk.sh
WORKDIR /root
CMD ["/bin/bash"]
