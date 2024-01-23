# APPS directory

The folder contains:
- configure-rancher-server-version.sh -> The script that will modify the version to be used for installing Rancher
- configure-cert-manager-version.sh -> The script that will modify the version to be used for installing cert-manager
- Makefile -> The file contains a series of shortcuts for deploying the Kubernetes resources of the various tools in the directory
- Tools directory (Example `rancher-server`) -> The folder contains custom resources, such as the `resources/custom-helm-values.yaml` file, which will override the base configurations

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
