#!/bin/bash
set -x
azure servicefabric application package copy HelloWorldApplication fabric:ImageStore
if [ $? -ne 0 ]; then
	echo "Application copy failed."
	exit 1
fi
azure servicefabric application type register HelloWorldApplication
if [ $? -ne 0 ]; then
	echo "Application type registration failed."
	exit 1
fi
version=`grep "ApplicationTypeVersion" HelloWorldApplication/ApplicationManifest.xml | cut -d'=' -f2 | sed -e 's/^"//'  -e 's/"$//'` 
eval azure servicefabric application create fabric:/HelloWorldApplication  HelloWorldApplicationType $version
if [ $? -ne 0 ]; then
	echo "Application creation failed."
	exit 1
fi


