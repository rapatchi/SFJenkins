#!/bin/bash
set -x
azure servicefabric application package copy HelloWorldStatelessApplication fabric:ImageStore
if [ $? -ne 0 ]; then
	echo "Application copy failed."
	exit 1
fi
azure servicefabric application type register HelloWorldStatelessApplication
if [ $? -ne 0 ]; then
	echo "Application type registration failed."
	exit 1
fi
version=`grep "ApplicationTypeVersion" HelloWorldStatelessApplication/ApplicationManifest.xml | cut -d'=' -f2 | sed -e 's/^"//'  -e 's/"$//'`
eval azure servicefabric application upgrade start --application-name fabric:/HelloWorldStatelessApplication --target-application-type-version ${version} --rolling-upgrade-mode Monitored
