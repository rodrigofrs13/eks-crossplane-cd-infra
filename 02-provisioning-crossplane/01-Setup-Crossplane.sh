# Instsall
# https://docs.crossplane.io/v1.17/software/install/


helm repo add crossplane-stable https://charts.crossplane.io/stable;

helm repo update;

helm upgrade --install crossplane crossplane-stable/crossplane \
--namespace crossplane-system \
--create-namespace \
--set args='{"--enable-environment-configs"}' \
--version 1.16.0;

# Pods
# kubectl get pods -n crossplane-system

# Acompanha
# kubectl logs -f -n crossplane-system deployment/crossplane

