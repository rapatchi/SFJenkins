#!/bin/bash
set -x
if [ $# -eq 0 ]; then
	url="http://localhost:19080"
else
	url="$1"
fi

#In case of local cluster, check if the cluster is up, if not, then try to bring it up first.
if [[ $url == *"localhost"* ]]; then
	echo "For local cluster, check if the cluster is already up or not and accordingly set up the cluster."
	if [ `systemctl | grep -i fabric | wc -l` == 1 ]; then
		echo "Local cluster is up, now will try to connect to the cluster."
	else 
		echo "cluster is not up, set up the cluster first."
		if [[ $EUID -ne 0 ]]; then
            echo "This script must be run as root, please open your IDE as root to set-up the local cluster." 1>&2
            exit 1
        fi
		sudo /opt/microsoft/sdk/servicefabric/common/clustersetup/devclustersetup.sh
		if [ $? -ne 0 ]; then
			echo "Dev cluster set-up failed."
			exit 1
		fi
		echo -n "Setting up cluster."
		n=`ps -eaf | grep -i "filestoreservice" | grep -v grep | wc -l`
		until [ $n -eq 3 ]; do
			echo -n "."
			n=`ps -eaf | grep -i "filestoreservice" | grep -v grep | wc -l`
			sleep 30
		done
	fi
fi

echo "Connecting to $url"
azure servicefabric cluster connect "$url"
if [ $? != 0 ]; then
	echo "Something went wrong while connecting to cluster."
	exit 1
fi
azure servicefabric cluster show
