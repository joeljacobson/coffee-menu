#!/bin/bash

export VERSION=0.1.1

dcos marathon app remove infra/coffee-menu
dcos package repo remove coffee-menu

./scripts/build.sh
DOCKER_TAG="coffee-menu" docker/server/build.bash
docker tag mesosphere/universe-server:coffee-menu mesosphere/dcosappstudio:coffee-menu-v$VERSION
docker push mesosphere/dcosappstudio:coffee-menu-v$VERSION

./deploy.sh
