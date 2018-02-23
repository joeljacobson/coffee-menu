#!/bin/bash

export VERSION=0.1.0
export TECH=glassfish
export TECHVERSION=5.0
export JDKVERSION=8u162-linux-x64

export DOCKERHUB_USER=mesosphere
export DOCKERHUB_REPO=dcosappstudio

echo Building $TECH Container
echo Version: $VERSION
echo $TECH Version: $TECHVERSION
echo JDK Version: $JDKVERSION

echo Downloading $TECH
curl -C - -L -o $TECH-$TECHVERSION.zip  http://download.oracle.com/$TECH/$TECHVERSION/release/$TECH-$TECHVERSION.zip
echo Downloading JDK $JDKVERSION
curl -C - -L -o jdk-$JDKVERSION.tar.gz -R -s -S -H "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u162-b12/0da788060d494f5095bf8624735fa2f1/jdk-$JDKVERSION.tar.gz

unzip $TECH-$TECHVERSION.zip
rm $TECH-$TECHVERSION.zip
mv glassfish* glassfish-$TECHVERSION

sed -ie 's/<Connector port="8080"/<Connector port="${port.http.nonssl}"/g' apache-$TECH-$TECHVERSION/conf/server.xml

echo docker build -t $DOCKERHUB_USER/$DOCKERHUB_REPO:coffeemenu-$TECH-$TECHVERSION-$JDKVERSION-$VERSION --build-arg JDKVERSION=$JDKVERSION --build-arg TECHVERSION=$TECHVERSION .
docker build -t $DOCKERHUB_USER/$DOCKERHUB_REPO:coffeemenu-$TECH-$TECHVERSION-$JDKVERSION-$VERSION --build-arg JDKVERSION=$JDKVERSION --build-arg TECHVERSION=$TECHVERSION .

docker push $DOCKERHUB_USER/$DOCKERHUB_REPO:coffeemenu-$TECH-$TECHVERSION-$JDKVERSION-$VERSION 
