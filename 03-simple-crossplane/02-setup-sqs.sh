
# Setup de um recurso diretamente pelo Crossplane

cat <<EOF | kubectl create -f -
apiVersion: sqs.aws.upbound.io/v1beta1
kind: Queue
metadata:
  name: first-queue-code
spec:
  forProvider:
    name: first-queue-code
    region: us-east-1
  providerConfigRef:
    name: irsa-providerconfig
EOF
