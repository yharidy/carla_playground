FROM ros:noetic
ARG CARLA_VERSION

# Install system dependencies for building and running ROS and CARLA ROS bridge
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
    && rm -rf /var/lib/apt/lists/*

# Set up ROS package sources
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key | apt-key add -

# Install ROS Noetic full desktop version (includes rviz, pcl, etc.)
RUN apt-get update && apt-get install -y \
    ros-noetic-desktop-full

# Make python3.8 the default python
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.8 1
RUN update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1

# Set up C++ development environment
RUN apt-get update && apt-get install -y \
    g++ \
    clang \
    lldb \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /root
COPY requirements.txt /root/requirements.txt
RUN pip install --upgrade pip
RUN pip install carla==${CARLA_VERSION} && \
    pip install -r /root/requirements.txt
RUN rm -f /etc/apt/sources.list.d/ros1-latest.list
RUN mkdir -p ~/carla-ros-bridge/catkin_ws/src && \
    cd ~/carla-ros-bridge && \
    git clone --recurse-submodules https://github.com/carla-simulator/ros-bridge.git catkin_ws/src/ros-bridge

RUN /bin/bash -c "source /opt/ros/noetic/setup.bash" && \
    cd ~/carla-ros-bridge/catkin_ws && \
    apt-get update && \
    rosdep update && \
    rosdep install --from-paths src --ignore-src -r 
    #catkin build
CMD ["/bin/bash"]