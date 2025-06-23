cat <<EOF | kubectl apply -f -
apiVersion: aws.upbound.io/v1beta1
kind: ProviderConfig
metadata:
  name: irsa-providerconfig
spec:
  credentials:
    source: WebIdentity
    webIdentity:
      roleARN: "arn:aws:iam::xxx:role/control-plane-admin"
EOF

## kk get providerconfigs.aws.upbound.io
## kk get crds | grep upbound