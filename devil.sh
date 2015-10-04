# DOCKER DEVELOPMENT
export DOCKER_MACHINE_VERSION=0.4.0
export DOCKER_COMPOSE_VERSION=1.4.0
export DOCKER_PROJECTS_FOLDER="$HOME/Projects/devil"
export COMPOSE_FILE="$DEVIL/docker-compose.yml"
export PATH="$DEVIL/bin":$PATH
if [ -x $DEVIL/bin/docker-machine ]; then
  eval "$(docker-machine env dev)"
fi
