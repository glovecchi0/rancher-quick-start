# BASE directory

The folder contains the [Helm Charts](https://helm.sh/docs/topics/charts/) of the applications that will be installed on the Kubernetes clusters.

The goal is to simulate local [versioning](https://en.wikipedia.org/wiki/Software_versioning) of all Kubernetes manifests, as may be necessary in an [air-gapped environment](https://ranchermanager.docs.rancher.com/getting-started/installation-and-upgrade/other-installation-methods/air-gapped-helm-cli-install).

## How can we download the Helm Charts of the various tools?

#### Rancher

```bash
sh download-rancher-server-helm-chart.sh -b branch_name
```

**If you look at the [Rancher repository](https://github.com/rancher/rancher), you will notice that the `branch_name` corresponds to the release of the application itself.**

#### Rancher Cleanup

```bash
sh download-rancher-cleanup-manifest.sh
```

#### cert-manager

```bash
sh download-cert-manager-helm-chart.sh -r cert-manager_release
```

**These scripts work perfectly from the macOS terminal; if you use any other Linux distribution, remove `''` from the `sed` command.**
