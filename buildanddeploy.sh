#!/bin/bash

export VERSION=0.1.1

dcos marathon app remove infra/coffee-menu
dcos package repo remove coffee-menu

cp repo/packages/W/wildfly/0/* repo/packages/W/wildfly/1/
cp repo/packages/W/wildfly/0/* repo/packages/W/wildfly/2/
cp repo/packages/W/wildfly/0/* repo/packages/W/wildfly/3/

cp repo/packages/J/jetty/0/* repo/packages/J/jetty/1/
cp repo/packages/J/jetty/0/* repo/packages/J/jetty/2/
cp repo/packages/J/jetty/0/* repo/packages/J/jetty/3/

cp repo/packages/T/tomcat/0/* repo/packages/T/tomcat/1/
cp repo/packages/T/tomcat/0/* repo/packages/T/tomcat/2/
cp repo/packages/T/tomcat/0/* repo/packages/T/tomcat/3/

./scripts/build.sh
DOCKER_TAG="coffee-menu" docker/server/build.bash
docker tag mesosphere/universe-server:coffee-menu mesosphere/dcosappstudio:coffee-menu-v$VERSION
docker push mesosphere/dcosappstudio:coffee-menu-v$VERSION

./deploy.sh
