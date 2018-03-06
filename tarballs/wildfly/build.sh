#!/bin/bash

export VERSION=0.1.0
export TECH=wildfly
export TECHVERSION=11.0.0
export JDKVERSION=8u162-linux-x64

export DOCKERHUB_USER=mesosphere
export DOCKERHUB_REPO=dcosappstudio

echo Building $TECH Container
echo Version: $VERSION
echo $TECH Version: $TECHVERSION
echo JDK Version: $JDKVERSION

echo Downloading $TECH
curl -C - -L -o wildfly-$TECHVERSION.Final.tar.gz  http://download.jboss.org/wildfly/11.0.0.Final/wildfly-$TECHVERSION.Final.tar.gz
echo Downloading JDK $JDKVERSION
curl -C - -L -o jdk-$JDKVERSION.tar.gz -R -s -S -H "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u162-b12/0da788060d494f5095bf8624735fa2f1/jdk-$JDKVERSION.tar.gz

tar xzf wildfly-$TECHVERSION.Final.tar.gz
rm -fr wildfly-$TECHVERSION.Final/welcome-content

cp start.template start.sh
sed -ie "s/__TECHVERSION__/$TECHVERSION/g" start.sh
sed -ie "s/__JDKVERSION__/$JDKVERSION/g" start.sh
rm start.she

tar czf wildfly-$TECHVERSION.Final-deploy.tar.gz wildfly-$TECHVERSION.Final start.sh

