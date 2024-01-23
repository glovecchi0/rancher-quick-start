#!/bin/bash

helpFunction()
{
   echo 
   echo "Syntax : sh $0 -b branch_name"
   echo
   echo "Options:"
   echo "-b release/v2.8     Enter the branch name of the rancher/rancher repository you want to download."
   echo
}

while getopts "b:" opt
do
   case "$opt" in
      b) RANCHER_BRANCH_NAME=$OPTARG
         if [[ $RANCHER_BRANCH_NAME != release/v* ]]
         then
           echo "Error: Invalid option"
           helpFunction
           exit 1
         fi
         RANCHER_SERVER_VERSION="$(echo $RANCHER_BRANCH_NAME | awk -F'/' '{ print $2 }')"
         if [[ "${#RANCHER_SERVER_VERSION}" == 4 ]]
         then 
           RANCHER_SERVER_VERSION=$RANCHER_SERVER_VERSION.0
         fi
         #echo $RANCHER_SERVER_VERSION
         if [ -d "rancher-server_$RANCHER_SERVER_VERSION" ]
         then
           echo "The Rancher release you entered has already been downloaded to the current directory."
           echo ""
           echo "> ls -l rancher-server_$RANCHER_SERVER_VERSION"
           ls -l rancher-server_$RANCHER_SERVER_VERSION
         else
           mkdir ./rancher-server_$RANCHER_SERVER_VERSION-all
           mkdir ./rancher-server_$RANCHER_SERVER_VERSION
           git clone git@github.com:rancher/rancher.git --branch $RANCHER_BRANCH_NAME ./rancher-server_$RANCHER_SERVER_VERSION-all
           mv ./rancher-server_$RANCHER_SERVER_VERSION-all/chart/* ./rancher-server_$RANCHER_SERVER_VERSION
           sed -i '' "s/version:.*/version: $RANCHER_SERVER_VERSION/g" ./rancher-server_$RANCHER_SERVER_VERSION/Chart.yaml
           sed -i '' "s/appVersion:.*/appVersion: $RANCHER_SERVER_VERSION/g" ./rancher-server_$RANCHER_SERVER_VERSION/Chart.yaml
           sed -i '' "s@%POST_DELETE_IMAGE_NAME%@rancher/rancher@g" ./rancher-server_$RANCHER_SERVER_VERSION/values.yaml
           sed -i '' "s/%POST_DELETE_IMAGE_TAG%/$RANCHER_SERVER_VERSION/g" ./rancher-server_$RANCHER_SERVER_VERSION/values.yaml
           rm -rf ./rancher-server_$RANCHER_SERVER_VERSION-all
         fi
         exit;;
     \?) echo "Error: Invalid option"
         helpFunction
         exit;;
   esac
done

if [ -z "$RANCHER_BRANCH_NAME" ]
then
   echo "Error: Invalid option"
   helpFunction
fi
