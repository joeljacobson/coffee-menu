# Running Java Application Server on DC/OS 1.10

Catalog with Wildfly (JBoss), Tomcat and Jetty

Add to you running cluster:
dcos marathon app add docker/server/marathon.json

When the task is up and running add catalog:
dcos package repo add --index=0 coffee-menu http://coffee-menu.marathon.l4lb.thisdcos.directory:80/repo

In the catalog you will have then 3 entries: Wildfly, JBoss & Tomcat
(You can define Java Options like in -Xmx either in marathon json, or in the UI)

If you don't like the combination of app-server version and JDK version you can run your own docker images.
Dockerfiles for building app-server / jdk images are provided under docker-images/

Please check out Joerg's excellent blog on how to tune & tweak your Java apps on DC/OS and containers in general:
https://jaxenter.com/nobody-puts-java-container-139373.html

Good luck!





