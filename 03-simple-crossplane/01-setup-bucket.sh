
# https://docs.crossplane.io/v1.16/concepts/providers/
# https://marketplace.upbound.io/providers/upbound/provider-family-aws/v1.16.0/providers


# Setup de um recurso diretamente pelo Crossplane


cat <<EOF | kubectl create -f -
apiVersion: s3.aws.upbound.io/v1beta1
kind: Bucket
metadata:
  generateName: crossplane-bucket-
spec:
  forProvider:
    region: us-east-1
  providerConfigRef:
    name: irsa-providerconfig
EOF