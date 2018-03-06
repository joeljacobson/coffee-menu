#!/bin/bash

export VERSION=0.1.0
export TECH=tomcat
export TECHVERSION=9.0.5
export JDKVERSION=8u162-linux-x64

export DOCKERHUB_USER=mesosphere
export DOCKERHUB_REPO=dcosappstudio

echo Building $TECH Container
echo Version: $VERSION
echo $TECH Version: $TECHVERSION
echo JDK Version: $JDKVERSION

echo Downloading $TECH
curl -C - -L -o apache-$TECH-$TECHVERSION.tar.gz  http://www-us.apache.org/dist/tomcat/tomcat-9/v$TECHVERSION/bin/apache-$TECH-$TECHVERSION.tar.gz
echo Downloading JDK $JDKVERSION
curl -C - -L -o jdk-$JDKVERSION.tar.gz -R -s -S -H "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u162-b12/0da788060d494f5095bf8624735fa2f1/jdk-$JDKVERSION.tar.gz

tar xzf apache-$TECH-$TECHVERSION.tar.gz
rm -fr apache-$TECH-$TECHVERSION/webapps/*

sed -ie 's/<Connector port="8080"/<Connector port="${port.http.nonssl}"/g' apache-$TECH-$TECHVERSION/conf/server.xml

cp start.template start.sh
sed -ie "s/__TECHVERSION__/$TECHVERSION/g" start.sh
sed -ie "s/__JDKVERSION__/$JDKVERSION/g" start.sh
rm start.she

tar czf apache-$TECH-$TECHVERSION-deploy.tar.gz apache-$TECH-$TECHVERSION start.sh
