cat <<EOF | kubectl apply -f -
apiVersion: helm.crossplane.io/v1beta1
kind: ProviderConfig
metadata:
  name: helm-provider
  namespace: crossplane-system
spec:
  credentials:
    source: InjectedIdentity
EOF

## kk get providerconfigs.helm.crossplane.io