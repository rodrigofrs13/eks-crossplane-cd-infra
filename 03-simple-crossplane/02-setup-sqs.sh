
# Setup de um recurso diretamente pelo Crossplane

cat <<EOF | kubectl create -f -
apiVersion: sqs.aws.upbound.io/v1beta1
kind: Queue
metadata:
  generateName: crossplane-queue-cd-code-recon-
spec:
  forProvider:
    region: us-east-1
  providerConfigRef:
    name: irsa-providerconfig

EOF

## kubectl get queue.sqs.aws.upbound.io

# Acompanha
# kubectl logs -f -n crossplane-system deployment/provider-aws-sqs-7a356e3a0f47