#!/bin/bash

# Get environment variables from the host machine
CARLA_VERSION="0.9.15"  # Replace with how you get CARLA_VERSION
DOCKER_SOCKET="${DOCKER_SOCKET:-/var/run/docker.sock}"
UID="$(id -u)"
GID="$(id -g)"

# Create or overwrite the .env file
cat > .env <<EOF
CARLA_VERSION=${CARLA_VERSION}
DOCKER_SOCKET=${DOCKER_SOCKET}
USER_UID=${UID}
USER_GID=${GID}
EOF

echo ".env file has been created/updated with the necessary environment variables."
