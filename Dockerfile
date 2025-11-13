# Use the specified base image
FROM ghcr.io/linuxserver/baseimage-selkies:debiantrixie

ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libsdl2-dev \
    libsdl2-ttf-2.0-0 \
    libsdl2-image-2.0-0 \
    xz-utils \
    wget \
    zenity && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Download and Extract PopTracker
RUN mkdir -p /app/poptracker && \
    wget https://github.com/black-sliver/PopTracker/releases/download/v0.32.1/poptracker_0-32-1_ubuntu-22-04-x86_64.tar.xz -O poptracker.tar.xz && \
    # --strip-components=1 handles potential top-level directory in the tarball.
    tar -xJf poptracker.tar.xz -C /app/poptracker --strip-components=1 && \
    chmod +x /app/poptracker/poptracker && \
    rm poptracker.tar.xz

# Download Wind Waker pack
RUN mkdir -p /app/poptracker/packs && \
    # Download the pack zip file
    wget https://github.com/Mysteryem/ww-poptracker/archive/refs/tags/v1.2.0.zip -O ww-pack.zip && \
    # Extract the zip file into the packs directory. This will create a folder like ww-poptracker-1.2.0 inside /app/poptracker/packs
    mv ww-pack.zip /app/poptracker/packs
    # Clean up the downloaded zip file

COPY autostart /defaults/autostart
