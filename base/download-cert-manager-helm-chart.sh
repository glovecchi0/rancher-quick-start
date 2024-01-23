#!/bin/bash

helpFunction()
{
   echo 
   echo "Syntax : sh $0 -r cert-manager_release"
   echo
   echo "Options:"
   echo "-r 1.13.3     Enter the version of cert-manager you want to deploy."
   echo
}

while getopts "r:" opt
do
   case "$opt" in
      r) CERTMANAGER_VERSION=$OPTARG
         if [[ $CERTMANAGER_VERSION == v* ]]
         then
           echo "Error: Invalid option"
           helpFunction
           exit 1
         fi
         if [ -d "cert-manager_v$CERTMANAGER_VERSION" ]
         then
           echo "The cert-manager release you entered has already been downloaded to the current directory."
           echo ""
           echo "> ls -l cert-manager_v$CERTMANAGER_VERSION"
           ls -l cert-manager_v$CERTMANAGER_VERSION
         else
           mkdir ./cert-manager_v$CERTMANAGER_VERSION && cd ./cert-manager_v$CERTMANAGER_VERSION
           curl -LO https://github.com/cert-manager/cert-manager/releases/download/v$CERTMANAGER_VERSION/cert-manager.crds.yaml
           curl -LO https://github.com/cert-manager/cert-manager/releases/download/v$CERTMANAGER_VERSION/cert-manager.yaml
         fi
         exit;;
     \?) echo "Error: Invalid option"
         helpFunction
         exit;;
   esac
done

if [ -z "$CERTMANAGER_VERSION" ]
then
   echo "Error: Invalid option"
   helpFunction
fi
