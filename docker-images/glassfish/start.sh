cp /mnt/mesos/sandbox/*war /opt/apache-tomcat-$TECHVERSION/webapps
cd /opt
tar xf jdk-$JDKVERSION.tar.gz
ln -s jdk1* java
export JAVA_HOME=/opt/java
export PATH=$JAVA_HOME/bin:$PATH

export JAVA_OPTS=$JAVA_OPTS -Dport.http.nonssl=${PORT0}

/opt/glassfish-$TECHVERSION/bin/catalina.sh run 
