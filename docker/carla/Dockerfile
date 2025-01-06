ARG CARLA_VERSION
FROM carlasim/carla:${CARLA_VERSION}

USER root

# Install required dependencies and add NVIDIA GPG key
RUN apt-get update && apt-get install -y gnupg curl && \
    curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/3bf863cc.pub | gpg --dearmor -o /usr/share/keyrings/nvidia-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/nvidia-archive-keyring.gpg] https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/nvidia-cuda.list && \
    apt-get update


RUN apt-get install -y software-properties-common && \
    apt-get install -y xdg-user-dirs \ 
    xdg-utils \
    mesa-utils \
    vulkan-utils \
    libvulkan1

RUN export XDG_RUNTIME_DIR=/tmp/runtime-carla && \
    mkdir -p  /tmp/runtime-carla && \
    chmod 700 /tmp/runtime-carla 

# Set the working directory and switch to the new user
WORKDIR /carla_workspace
USER carla
# Create a directory for runtime files
RUN mkdir -p /tmp/runtime-dir

# Set the XDG_RUNTIME_DIR environment variable
ENV XDG_RUNTIME_DIR=/tmp/runtime-dir
# Copy files into the container and set permissions
COPY --chown=carla:carla start_carla.sh /carla_workspace/
RUN chmod +x start_carla.sh 

# Default command
CMD ["tail", "-f", "/dev/null"]
# Uncomment if you want to run CARLA automatically
# CMD ["./start_carla.sh", "-RenderOffScreen"]