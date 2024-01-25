#!/bin/bash

mkdir ./rancher-cleanup-manifest
git clone git@github.com:rancher/rancher-cleanup.git
mv ./rancher-cleanup/deploy/rancher-cleanup.yaml ./rancher-cleanup-manifest/
rm -Rf ./rancher-cleanup
