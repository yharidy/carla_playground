ARG CARLA_VERSION
FROM carlasim/carla:${CARLA_VERSION}

WORKDIR /carla_workspace
# Switch to the 'carla' user
USER carla
COPY start_carla.sh /carla_workspace/start_carla.sh
CMD ["tail", "-f", "/dev/null"]