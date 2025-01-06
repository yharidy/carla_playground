FROM ros:noetic
ARG CARLA_VERSION
USER root

# Install system dependencies, ROS packages, and build tools
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    python3.8 \
    python3.8-dev \
    python3.8-distutils \
    python3-pip \
    python3-colcon-common-extensions \
    git \
    cmake \
    ros-noetic-carla-msgs \
    ros-noetic-rosbridge-suite \
    ros-noetic-geometry-msgs \
    ros-noetic-std-msgs \
    ros-noetic-sensor-msgs \
    ros-noetic-catkin \
    g++ \
    clang \
    lldb \
    python3-catkin-tools \
    # Uncomment this line to include the full ROS Noetic desktop environment
    ros-noetic-desktop-full \
    && rm -rf /var/lib/apt/lists/*

# install docker and docker compose plugin
RUN apt-get install ca-certificates curl && \
    install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc && \
    chmod a+r /etc/apt/keyrings/docker.asc
    
# Add the repository to Apt sources:
RUN echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null \
    && apt-get update

RUN apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
# Set up C++ development environment and ROS package sources
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' \
    && curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key | apt-key add -

# Run ROS Noetic setup script in every new shell
RUN echo 'source /opt/ros/noetic/setup.bash' >> /root/.bashrc
COPY .bash_aliases /root/.bash_aliases

# Make python3.8 the default python
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.8 1 \
    && update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1

# Install Python dependencies
COPY requirements.txt /root/requirements.txt
RUN pip install --upgrade pip 
RUN pip install carla==${CARLA_VERSION} \
    && pip install -r /root/requirements.txt

# Remove redundant ROS 1 sources (if necessary)
RUN rm -f /etc/apt/sources.list.d/ros1-latest.list

# Install CARLA ROS bridge
RUN mkdir -p ~/carla-ros-bridge/catkin_ws/src && \
    cd ~/carla-ros-bridge && \
    git clone --recurse-submodules https://github.com/carla-simulator/ros-bridge.git catkin_ws/src/ros-bridge

RUN cd ~/carla-ros-bridge/catkin_ws && \
    apt-get update && \
    rosdep update && \
    rosdep install --from-paths src --ignore-src -r && \
    /bin/bash -c "source /opt/ros/noetic/setup.bash && catkin build"

CMD ["/bin/bash"]
