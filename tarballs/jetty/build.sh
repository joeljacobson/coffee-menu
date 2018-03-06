#!/bin/bash

export VERSION=0.1.0
export TECH=jetty
export TECHVERSION=9.4.8.v20171121
export JDKVERSION=8u162-linux-x64

export DOCKERHUB_USER=mesosphere
export DOCKERHUB_REPO=dcosappstudio

echo Building $TECH Container
echo Version: $VERSION
echo $TECH Version: $TECHVERSION
echo JDK Version: $JDKVERSION

echo Downloading $TECH
curl -C - -L -o jetty-distribution-$TECHVERSION.tar.gz  http://central.maven.org/maven2/org/eclipse/jetty/jetty-distribution/$TECHVERSION/jetty-distribution-$TECHVERSION.tar.gz
echo Downloading JDK $JDKVERSION
curl -C - -L -o jdk-$JDKVERSION.tar.gz -R -s -S -H "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u162-b12/0da788060d494f5095bf8624735fa2f1/jdk-$JDKVERSION.tar.gz

cp start.template start.sh
sed -ie "s/__TECHVERSION__/$TECHVERSION/g" start.sh
sed -ie "s/__JDKVERSION__/$JDKVERSION/g" start.sh
rm start.she

tar xzf jetty-distribution-$TECHVERSION.tar.gz
tar czf jetty-distribution-$TECHVERSION-deploy.tar.gz jetty-distribution-$TECHVERSION start.sh
