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
         if [ ! -d "../base/cert-manager_v$CERTMANAGER_VERSION" ]
         then
           echo "The cert-manager release you entered was not downloaded to the \"base\" directory."
           echo ""
           echo "> ls -l ../base/cert-manager_v$CERTMANAGER_VERSION"
           ls -l ../base/cert-manager_v$CERTMANAGER_VERSION
         else
           sed -i '' "s@kubectl apply.*@kubectl apply -f ../base/cert-manager_v$CERTMANAGER_VERSION -n cert-manager@g" ./Makefile
           sed -i '' "s@kubectl delete -f.*@kubectl delete -f ../base/cert-manager_v$CERTMANAGER_VERSION -n cert-manager@g" ./Makefile
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
