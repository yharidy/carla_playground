#!/bin/bash

DOCKER_COMPOSE_FILE=/workspace/docker-compose.yml
CARLA_CONTAINER_NAME=carla

is_carla_running() {
    docker ps --format '{{.Names}}' | grep -q "^${CARLA_CONTAINER_NAME}$"
}

start_carla() {
    if is_carla_running; then
        echo "Carla is already running"
    else
        docker compose -f $DOCKER_COMPOSE_FILE up -d carla
        echo "Carla container started"
    fi
    docker exec carla ./start_carla.sh
    echo "Carla server started"
}

stop_carla() {
    if is_carla_running; then
        docker stop carla
        echo "Carla stopped"
        docker rm carla
        echo "Carla container removed"
    else
        echo "Carla is not running"
    fi
}

restart_carla() {
    stop_carla
    start_carla
}

case $1 in 
    start)
        start_carla
        ;;
    stop)
        stop_carla
        ;;
    restart)
        restart_carla
        ;;
    *)
        echo "Usage: $0 {start|stop|restart}"
        exit 1
        ;;
esac