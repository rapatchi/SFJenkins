#!/bin/bash
set -x
appplicationCount=`azure servicefabric application show "fabric:/HelloWorldStatelessApplication" | grep fabric:/HelloWorldStatelessApplication | wc -l`
if [[ "$appplicationCount" -eq "0" ]];then
	echo "Deploying Application"
	/bin/bash install.sh
else	
	echo "CleanUp: Undeploying existing app"
	/bin/bash uninstall.sh
	echo "Redeploying"
	/bin/bash install.sh
fi
