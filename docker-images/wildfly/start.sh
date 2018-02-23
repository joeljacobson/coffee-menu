cp /mnt/mesos/sandbox/*war /opt/wildfly-$TECHVERSION.Final/standalone/deployments
cd /opt
tar xf jdk-$JDKVERSION.tar.gz
ln -s jdk1* java
export JAVA_HOME=/opt/java
export PATH=$JAVA_HOME/bin:$PATH

/opt/wildfly-$TECHVERSION.Final/bin/standalone.sh -Djboss.http.port=$PORT0 -Djboss.bind.address=0.0.0.0
