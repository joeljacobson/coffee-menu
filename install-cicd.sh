#!/bin/bash
export APPLOWERCASE=coffeemenu

export DCOS_URL=$(dcos config show core.dcos_url)
echo DCOS_URL: $DCOS_URL

echo Determing public node ip...
export PUBLICNODEIP=$(./findpublic_ips.sh | head -1 | sed "s/.$//" )
echo Public node ip: $PUBLICNODEIP
echo ---------------


if [ ${#PUBLICNODEIP} -le 6 ] ;
then
        echo Can not find a public node ip. JQ in path?
        exit -1
fi
echo ---------------

cp config/gitlab.json.template config/gitlab.json
sed -ie "s@\$PINNEDNODE@@g;" config/gitlab.json

sed  '/gitlab/d' /etc/hosts >./hosts
sed  -ie '/nexus/d' ./hosts
sed  -ie '/coffeemenu/d' ./hosts

echo "$PUBLICNODEIP gitlab.$APPLOWERCASE.mesosphere.io" >>./hosts
echo "$PUBLICNODEIP nexus.$APPLOWERCASE.mesosphere.io" >>./hosts
echo "$PUBLICNODEIP jenkins.$APPLOWERCASE.mesosphere.io" >>./hosts
echo "$PUBLICNODEIP tomcat.$APPLOWERCASE.mesosphere.io" >>./hosts
echo "$PUBLICNODEIP jetty.$APPLOWERCASE.mesosphere.io" >>./hosts
echo "$PUBLICNODEIP wildfly.$APPLOWERCASE.mesosphere.io" >>./hosts

echo We are going to add a couple of hosts to your /etc/hosts. Therefore we need your local password.
sudo mv hosts /etc/hosts


echo Installing gitlab...
dcos marathon app add config/gitlab.json

echo Installing others....
dcos marathon app add docker/server/marathon.json
dcos marathon app add config/marathon-lb-config.json
dcos marathon app add config/nexus-config.json
dcos package install --yes --cli dcos-enterprise-cli

dcos package install --yes jenkins --package-version=3.3.0-2.73.1 --options=jenkins-config.json

echo Waiting for gitlab UI to be available
until $(curl --output /dev/null --silent --head --fail http://gitlab.$APPLOWERCASE.mesosphere.io); do
    printf '.'
    sleep 5
done
	

echo
echo I am going to open a browser window to gitlab. Please set the root user password there to \"rootroot\" and confirm it with \"rootroot\"
echo Afterwards please logon to gitlab \(in the browser\) as user \"root\" with password \"rootroot\"
echo When done please come back.
open http://gitlab.$APPLOWERCASE.mesosphere.io:10080
read -p "Press key when you set the password and are logged in as root." -n1 -s 
echo
echo On the bottom of the gitlab webpage is a green button \"New Project\". Please press it.
read -p "Press key when you are on the \"New project\" page." -n1 -s 
echo
echo Press the \"GitHub\" button.
read -p "Press a key when you are on the \"Import Projects from GitHub\" page." -n1 -s
echo
echo Here comes your \"Personal Access Token\":
echo Please copy the github token provided elsewhere and paste it into the browser form. Then press the green \"List Your GitHub Repositories\" button.
read -p "Press button when done." -n1 -s
echo
echo You can see all the existing projects now. Please look for \"Petclinic\" and press the \"Import\" button on the right.
read -p "Press button when done." -n1 -s
echo
echo After a while the row with \"Petclinic\" turns green. Please click the link \"root/DCOSAppStudio-CICD\" in the "To GitLab" column.
echo Congratulations! We are done setting up gitlab.

echo
echo .
echo We are setting up Jenkins now. 
read -p "Press button when ready." -n1 -s
echo
echo Next step is to create the build pipleine. In the browser window please enter \"$APP\" in the \"Enter Item Name\" text boxcall and select Pipeline as type and then press OK
open $DCOS_URL/service/dev%2Ftools%2Fjenkins/view/all/newJob
read -p "Press button when ready." -n1 -s
echo
echo Now check Poll SCM and use "* * * * *" as schedule which means we poll every minute \(5 Asterisk seperated by space\). Press Apply. Scroll down to Pipeline and select \"Pipeline script from SCM\". Select Git as SCM
read -p "Press button when ready." -n1 -s
echo
echo Next we need to define the repository. Please enter http://gitlab.marathon.l4lb.thisdcos.directory/root/DCOSAppStudio-CICD.git as Repository URL and select root/******** as credentials. Press Apply
read -p "Press button when ready." -n1 -s
echo We are all set now. Thank you for your patience. You can now start build-pipelines by executing the upgrade.sh or downgrade.sh script in the folder where we cloned the repo into.
echo Good luck!
dcos package repo add --index=0 coffee-menu http://coffee-menu.marathon.l4lb.thisdcos.directory:80/repo
