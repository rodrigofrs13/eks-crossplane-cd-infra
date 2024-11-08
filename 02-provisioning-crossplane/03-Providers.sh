#kubectl config use-context controlplane;
export PROVIDER=irsa-providerconfig
export PROVIDERHELM=helm-provider



#### Bucket S3
cat <<EOF | kubectl apply -f -
apiVersion: pkg.crossplane.io/v1
kind: Provider
metadata:
  name: provider-aws-s3
spec:
  package: xpkg.upbound.io/upbound/provider-aws-s3:v1.10.0
  runtimeConfigRef:
    name: ${PROVIDER}
EOF


#### Bucket SQS
cat <<EOF | kubectl apply -f -
apiVersion: pkg.crossplane.io/v1
kind: Provider
metadata:
  name: provider-aws-sqs
spec:
  package: xpkg.upbound.io/upbound/provider-aws-sqs:v1.9.0
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
  package: xpkg.upbound.io/upbound/provider-aws-ec2:v1.9.0
  runtimeConfigRef:
    name: ${PROVIDER}
EOF

#### Bucket EKS
cat <<EOF | kubectl apply -f -
apiVersion: pkg.crossplane.io/v1
kind: Provider
metadata:
  name: provider-aws-eks
spec:
  package: xpkg.upbound.io/upbound/provider-aws-eks:v1.11.0
  runtimeConfigRef:
    name: ${PROVIDER}
EOF


#### Bucket IAM
cat <<EOF | kubectl apply -f -
apiVersion: pkg.crossplane.io/v1
kind: Provider
metadata:
  name: provider-aws-iam
spec:
  package: xpkg.upbound.io/upbound/provider-aws-iam:v1.11.0
  runtimeConfigRef:
    name: ${PROVIDER}
EOF

#### Bucket KMS
cat <<EOF | kubectl apply -f -
apiVersion: pkg.crossplane.io/v1
kind: Provider
metadata:
  name: provider-aws-kms
spec:
  package: xpkg.upbound.io/upbound/provider-aws-kms:v1.11.0
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
  package: xpkg.upbound.io/upbound/provider-aws-lambda:v1.9.0
  runtimeConfigRef:
    name: ${PROVIDER}
EOF

# AWS VPC
cat <<EOF | kubectl apply -f -
apiVersion: pkg.crossplane.io/v1
kind: Provider
metadata:
  name: provider-aws-vpc
spec:
  package: xpkg.upbound.io/upbound/provider-aws-vpc:v1.9.0
  runtimeConfigRef:
    name: ${PROVIDER}  
EOF



# AWS KUBERNETES
cat <<EOF | kubectl apply -f -
apiVersion: pkg.crossplane.io/v1
kind: Provider
metadata:
  name: provider-kubernetes
spec:
  package: xpkg.upbound.io/crossplane-contrib/provider-kubernetes:v0.14.0
  runtimeConfigRef:
    name: ${PROVIDER}  
EOF

# AWS EventBridge
cat <<EOF | kubectl apply -f -
apiVersion: pkg.crossplane.io/v1
kind: Provider
metadata:
  name: provider-aws-scheduler
spec:
  package: xpkg.upbound.io/upbound/provider-aws-scheduler:v0.46.0
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


# HELM
cat <<EOF | kubectl apply -f -
apiVersion: pkg.crossplane.io/v1
kind: Provider
metadata:
  name: provider-aws-cloudwatch
spec:
  package: xpkg.upbound.io/upbound/provider-aws-cloudwatch:v1.13.0
  runtimeConfigRef:
    name: ${PROVIDER}    
EOF


# SSM
cat <<EOF | kubectl apply -f -
apiVersion: pkg.crossplane.io/v1
kind: Provider
metadata:
  name: provider-aws-ssm
spec:
  package: xpkg.upbound.io/upbound/provider-aws-ssm:v1.14.0
  runtimeConfigRef:
    name: ${PROVIDER}  
EOF


# ASG
cat <<EOF | kubectl apply -f -
apiVersion: pkg.crossplane.io/v1
kind: Provider
metadata:
  name: provider-aws-autoscaling
spec:
  package: xpkg.upbound.io/upbound/provider-aws-autoscaling:v1.14.0
  runtimeConfigRef:
    name: ${PROVIDER}  
EOF

# kk get providers