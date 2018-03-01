cp /mnt/mesos/sandbox/*war /opt/jetty-distribution-$TECHVERSION/webapps/root.war
cd /opt
tar xf jdk-$JDKVERSION.tar.gz
ln -s jdk1* java
export JAVA_HOME=/opt/java
export JAVA=$JAVA_HOME/bin/java
export PATH=$JAVA_HOME/bin:$PATH

export JETTY_PORT=$PORT0
export JETTY_ARGS=jetty.http.port=$PORT0
export JAVA_OPTIONS=$JAVA_OPTS
/opt/jetty-distribution-$TECHVERSION/bin/jetty.sh run
