
#!/bin/bash

dcos marathon app add docker/server/marathon.json

sleep 60
dcos package repo add --index=0 coffee-menu http://coffee-menu.marathon.l4lb.thisdcos.directory:80/repo
