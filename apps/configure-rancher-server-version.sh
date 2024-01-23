#!/bin/bash

helpFunction()
{
   echo 
   echo "Syntax : sh $0 -r rancher_release"
   echo
   echo "Options:"
   echo "-r 2.8     Enter the version of Rancher you want to deploy (> 2.*.*)."
   echo
}

while getopts "r:" opt
do
   case "$opt" in
      r) RANCHER_VERSION=$OPTARG
         if [[ $RANCHER_VERSION != 2.* ]]
         then
           echo "Error: Invalid option"
           helpFunction
           exit 1
         fi
         if [[ "${#RANCHER_VERSION}" == 3 ]]
         then 
           RANCHER_VERSION=$RANCHER_VERSION.0
         fi
         if [ ! -d "../base/rancher-server_v$RANCHER_VERSION" ]
         then
           echo "The Rancher release you entered was not downloaded to the \"base\" directory."
           echo ""
           echo "> ls -l ../base/rancher-server_$RANCHER_VERSION"
           ls -l ../base/rancher-server_$RANCHER_VERSION
         else
           sed -i '' "s@helm install rancher.*@helm install rancher ../base/rancher-server_v$RANCHER_VERSION --values rancher-server/resources/custom-helm-values.yaml -n cattle-system@g" ./Makefile
           sed -i '' "s@helm upgrade rancher.*@helm upgrade rancher ../base/rancher-server_v$RANCHER_VERSION --values rancher-server/resources/custom-helm-values.yaml -n cattle-system@g" ./Makefile
         fi
         exit;;
     \?) echo "Error: Invalid option"
         helpFunction
         exit;;
   esac
done

if [ -z "$RANCHER_VERSION" ]
then
   echo "Error: Invalid option"
   helpFunction
fi
