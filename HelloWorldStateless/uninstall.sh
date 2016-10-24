#!/bin/bash
set -x
azure servicefabric application delete fabric:/HelloWorldStatelessApplication
if [ $? -ne 0 ]; then
	echo "Application removal failed."
	exit 1
fi
version=`grep "ApplicationTypeVersion" HelloWorldStatelessApplication/ApplicationManifest.xml | cut -d'=' -f2 | sed -e 's/^"//'  -e 's/"$//' `
azure servicefabric application type unregister HelloWorldStatelessApplicationType $version
if [ $? -ne 0 ]; then
	echo "Unregistering application type failed."
	exit 1
fi

