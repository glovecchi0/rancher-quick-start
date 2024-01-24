# APPS directory

The folder contains:
- configure-rancher-server-version.sh -> the script that will modify the version to be used for installing Rancher
- configure-cert-manager-version.sh -> the script that will modify the version to be used for installing cert-manager
- Makefile -> the file contains a series of shortcuts for deploying the Kubernetes resources of the various tools in the directory
- Tools directory (Example `rancher-server`) -> the folder contains custom resources, such as the `resources/custom-helm-values.yaml` file, which will override the base configurations

## Prerequisites

- a working Kubernetes cluster -> and consequently exports the [KUBECONFIG variable](https://kubernetes.io/docs/tasks/access-application-cluster/configure-access-multiple-clusters/#set-the-kubeconfig-environment-variable)
- ensure you have reviewed the [Rancher Support Matrix](https://www.suse.com/suse-rancher/support-matrix/all-supported-versions/) and that your cluster meets the suggested [hardware requirements](https://ranchermanager.docs.rancher.com/getting-started/installation-and-upgrade/installation-requirements#hardware-requirements)
- configure the [rancher-server/resources/custom-helm-values.yaml](./rancher-server/resources/custom-helm-values.yaml) file as you see fit -> **this setup works perfectly in the Cloud environment, as the `rancher` K8s Service of type `LoadBalancer` will automatically create a Cloud LB and assign an external IP to reach the Rancher URL**

## How to configure the version of Rancher

```bash
sh configure-rancher-server-version.sh -r rancher_release
```

## How to configure the version of cert-manager

```bash
sh configure-cert-manager-version.sh -r cert-manager_release
```

## How to install the tools

#### Rancher Server with self-signed certificates

```bash
make kubectl-install-cert-manager
make helm-install-rancher-server
```
