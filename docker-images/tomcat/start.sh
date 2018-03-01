cp /mnt/mesos/sandbox/*war /opt/apache-tomcat-$TECHVERSION/webapps/ROOT.war
cd /opt
tar xf jdk-$JDKVERSION.tar.gz
ln -s jdk1* java
export JAVA_HOME=/opt/java
export PATH=$JAVA_HOME/bin:$PATH

export JAVA_OPTS="$JAVA_OPTS -Dport.http.nonssl=$PORT0"

/opt/apache-tomcat-$TECHVERSION/bin/catalina.sh run 
