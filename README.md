# Rancher Quick Start

One-click Rancher deployment to any Kubernetes cluster.

## How the repository is structured

```
.
├── base/
│   ├── download-cert-manager-helm-chart.sh
│   ├── download-rancher-server-helm-chart.sh
│   ├── cert-manager_v1.13/    # Example
│   ├── rancher-server_v2.8.0/ # Example
│   └── README.md
├── apps/
│   ├── configure-cert-manager-version.sh
│   ├── configure-rancher-server-version.sh
│   ├── Makefile
│   ├── cert-manager/ # Not required in case of Public/Private CA
│   ├── rancher-server/
│   └── README.md
└── README.md

```

#### Read the [README.md](base/README.md) file inside the `base` directory to understand its logic and how the scripts work.

#### Read the [README.md](apps/README.md) file inside the `apps` directory to understand its logic and how the scripts work.
