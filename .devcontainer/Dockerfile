# Use an Ubuntu base image
FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive
ENV CARLA_VERSION=0.9.15
# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    software-properties-common \
    cmake \
    g++ \
    git \
    libboost-all-dev \
    python3 \
    python3-pip \
    wget \
    mesa-utils \
    libopengl0 \
    libglu1-mesa-dev \
    libsm6 \
    libxext6 \
    libxrender-dev \
    libglib2.0-0 \
    xvfb \
    && apt-get clean

# Install CARLA dependencies
RUN pip3 install --upgrade pip && \
    pip3 install pygame numpy conan

# # Set up CARLA environment
# RUN mkdir -p /workspace/carla
# WORKDIR /workspace/carla

# RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1AF1527DE64CB8D9
# RUN add-apt-repository "deb [arch=amd64] http://dist.carla.org/carla(lsb_release -sc) main"
# RUN apt-get update # Update the Debian package index
# RUN apt-get install carla-simulator=={CARLA_VERSION}

# # Set environment variables
# ENV CARLA_SERVER=/workspace/carla/CarlaUE4.sh
