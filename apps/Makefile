.PHONY: install-cert-manager
install-cert-manager:
	kubectl apply -f ../base/cert-manager_v1.13.3 -n cert-manager || true
	sleep 60

.PHONY: uninstall-cert-manager
uninstall-cert-manager:
	kubectl delete -f ../base/cert-manager_v1.13.3 -n cert-manager || true
	sleep 60
	kubectl get ns cert-manager -ojson | jq '.spec.finalizers = []' | kubectl replace --raw "/api/v1/namespaces/cert-manager/finalize" -f - || true
	kubectl get ns cert-manager -ojson | jq '.metadata.finalizers = []' | kubectl replace --raw "/api/v1/namespaces/cert-manager/finalize" -f - || true
	kubectl delete namespace cert-manager --force --grace-period=0

.PHONY: install-rancher-server
install-rancher-server:
	kubectl create namespace cattle-system || true
	helm install rancher ../base/rancher-server_v2.8.0 --values rancher-server/resources/custom-helm-values.yaml -n cattle-system

.PHONY: upgrade-rancher-server
upgrade-rancher-server:
	helm upgrade rancher ../base/rancher-server_v2.8.0 --values rancher-server/resources/custom-helm-values.yaml -n cattle-system

.PHONY: uninstall-rancher-server
uninstall-rancher-server:
	kubectl create -f ../base/rancher-cleanup-manifest/rancher-cleanup.yaml || true
	kubectl -n kube-system logs -l job-name=cleanup-job -f
