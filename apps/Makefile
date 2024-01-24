.PHONY: kubectl-install-cert-manager
kubectl-install-cert-manager:
	kubectl create namespace cert-manager || true
	kubectl apply -f ../base/cert-manager_v1.13.3

.PHONY: kubectl-uninstall-cert-manager
kubectl-uninstall-cert-manager:
	kubectl get ns cert-manager -ojson | jq '.spec.finalizers = []' | kubectl replace --raw "/api/v1/namespaces/cert-manager/finalize" -f - || true
	kubectl get ns cert-manager -ojson | jq '.metadata.finalizers = []' | kubectl replace --raw "/api/v1/namespaces/cert-manager/finalize" -f - || true
	kubectl delete -f ../base/cert-manager_v1.13.3 || true

.PHONY: helm-install-rancher-server
helm-install-rancher-server:
	kubectl create namespace cattle-system || true
	helm install rancher ../base/rancher-server_v2.8.0 --values rancher-server/resources/custom-helm-values.yaml -n cattle-system

.PHONY: helm-upgrade-rancher-server
helm-upgrade-rancher-server:
	helm upgrade rancher ../base/rancher-server_v2.8.0 --values rancher-server/resources/custom-helm-values.yaml -n cattle-system

#.PHONY: helm-uninstall-rancher-server
#helm-uninstall-rancher-server:
#	helm uninstall rancher --wait -n cattle-system || true
