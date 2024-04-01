#!/usr/bin/env bash

# This function is used to install the JlinkExe package
function install_jlink() {
    dpkg --unpack /tmp/JLink_Linux_V794j_x86_64.deb \
    && rm -f /var/lib/dpkg/info/jlink.postinst \
    && dpkg --configure jlink \
    && apt install -yf
}

# Install JlinkExe and Systemview
apt update && \
    echo '#!/bin/bash\necho not running udevadm $@' > /usr/bin/udevadm && \
    chmod +x /usr/bin/udevadm && \
    install_jlink || \
    (echo "Fixing dependencies" && apt install -y --fix-broken && install_jlink) && \
    dpkg -i /tmp/SystemView_Linux_V352a_x86_64.deb