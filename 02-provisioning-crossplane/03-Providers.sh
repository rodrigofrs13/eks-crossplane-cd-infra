# https://docs.crossplane.io/v1.16/concepts/providers/
# https://marketplace.upbound.io/providers/upbound/provider-family-aws/v1.16.0/providers

export PROVIDER=irsa-providerconfig # Nome do DeploymentRuntimeConfig


#### Bucket S3
cat <<EOF | kubectl apply -f -
apiVersion: pkg.crossplane.io/v1
kind: Provider
metadata:
  name: provider-aws-s3
spec:
  package: xpkg.upbound.io/upbound/provider-aws-s3:v1.14.0
  runtimeConfigRef:
    name: ${PROVIDER}
EOF


#### SQS
cat <<EOF | kubectl apply -f -
apiVersion: pkg.crossplane.io/v1
kind: Provider
metadata:
  name: provider-aws-sqs
spec:
  package: xpkg.upbound.io/upbound/provider-aws-sqs:v1.14.0
  runtimeConfigRef:
    name: ${PROVIDER}
EOF


#### EC2
cat <<EOF | kubectl apply -f -
apiVersion: pkg.crossplane.io/v1
kind: Provider
metadata:
  name: provider-aws-ec2
spec:
  package: xpkg.upbound.io/upbound/provider-aws-ec2:v1.14.0
  runtimeConfigRef:
    name: ${PROVIDER}
EOF

#### EKS
cat <<EOF | kubectl apply -f -
apiVersion: pkg.crossplane.io/v1
kind: Provider
metadata:
  name: provider-aws-eks
spec:
  package: xpkg.upbound.io/upbound/provider-aws-eks:v1.14.0
  runtimeConfigRef:
    name: ${PROVIDER}
EOF


#### IAM
cat <<EOF | kubectl apply -f -
apiVersion: pkg.crossplane.io/v1
kind: Provider
metadata:
  name: provider-aws-iam
spec:
  package: xpkg.upbound.io/upbound/provider-aws-iam:v1.14.0
  runtimeConfigRef:
    name: ${PROVIDER}
EOF


#### Bucket Lambda
cat <<EOF | kubectl apply -f -
apiVersion: pkg.crossplane.io/v1
kind: Provider
metadata:
  name: provider-aws-lambda
spec:
  package: xpkg.upbound.io/upbound/provider-aws-lambda:v1.14.0
  runtimeConfigRef:
    name: ${PROVIDER}
EOF

# HELM
cat <<EOF | kubectl apply -f -
apiVersion: pkg.crossplane.io/v1
kind: Provider
metadata:
  name: provider-helm
spec:
  package: xpkg.upbound.io/crossplane-contrib/provider-helm:v0.19.0
  runtimeConfigRef:
    name: ${PROVIDER}  
EOF

# Criar o Provider AWS
cat <<EOF | kubectl apply -f -
apiVersion: pkg.crossplane.io/v1
kind: Provider
metadata:
  name: provider-aws
spec:
  package: xpkg.upbound.io/crossplane-contrib/provider-aws:v0.43.1
EOF