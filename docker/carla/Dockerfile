ARG CARLA_VERSION
FROM carlasim/carla:${CARLA_VERSION}

USER root
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/3bf863cc.pub

RUN apt-get update && \
    apt-get install -y xdg-user-dirs \ 
    xdg-utils \
    mesa-utils \
    software-properties-common

RUN export XDG_RUNTIME_DIR=/tmp/runtime-carla && \
    mkdir -p  /tmp/runtime-carla && \
    chmod 700 /tmp/runtime-carla 

# Set the working directory and switch to the new user
WORKDIR /carla_workspace
USER carla
# Copy files into the container and set permissions
COPY --chown=carla:carla start_carla.sh /carla_workspace/
RUN chmod +x start_carla.sh 

# Default command
CMD ["tail", "-f", "/dev/null"]
# Uncomment if you want to run CARLA automatically
# CMD ["./start_carla.sh", "-RenderOffScreen"]