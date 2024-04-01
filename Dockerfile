FROM ubuntu:22.04

# Copy SEGGER dependencies to /tmp folder
COPY JLink_Linux_V794j_x86_64.deb /tmp
COPY SystemView_Linux_V352a_x86_64.deb /tmp
COPY jlink.sh /tmp

# Install required packages
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    cmake \
    ninja-build \
    unzip \
    libgtk2.0-0 \
    openjdk-11-jre-headless \
    libswt-gtk-4-java \
    libxtst6 \
    libx11-6 \
    xvfb \
    wget \
    libstdc++6 \
    dbus-x11 \
    libncurses5 \
    libusb-1.0-0-dev \
    python3.10-venv \
    cppcheck \
    clang-format

RUN bash /tmp/jlink.sh

# Copy STM32CubeIDE files
COPY st/ /opt/st

# Set up the workspace
WORKDIR /workspaces

# Set the environment variables
ENV PATH="/opt/st/stm32cubeide_1.11.2:/opt/st/stm32cubeide_1.11.2/plugins/com.st.stm32cube.ide.mcu.externaltools.gnu-tools-for-stm32.10.3-2021.10.linux64_1.0.100.202210260954/tools/bin:${PATH}"

RUN wget -qO /usr/local/bin/ninja.gz https://github.com/ninja-build/ninja/releases/latest/download/ninja-linux.zip
RUN unzip /usr/local/bin/ninja.gz -d /usr/local/bin
RUN chmod a+x /usr/local/bin/ninja
RUN rm /usr/local/bin/ninja.gz
RUN rm -f /tmp/JLink_Linux_V794j_x86_64.deb
RUN rm -f /tmp/SystemView_Linux_V352a_x86_64.deb
RUN rm -r /tmp/jlink.sh
