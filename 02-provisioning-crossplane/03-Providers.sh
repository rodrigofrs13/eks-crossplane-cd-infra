# kubectl config use-context controlplane
export PROVIDER=irsa-providerconfig

#### Provider AWS S3
cat <<EOF | kubectl apply -f -
apiVersion: pkg.crossplane.io/v1
kind: Provider
metadata:
  name: provider-aws-s3
spec:
  package: xpkg.upbound.io/upbound/provider-aws-s3:v1.15.0
  runtimeConfigRef:
    name: ${PROVIDER}
EOF

#### Provider AWS SQS
cat <<EOF | kubectl apply -f -
apiVersion: pkg.crossplane.io/v1
kind: Provider
metadata:
  name: provider-aws-sqs
spec:
  package: xpkg.upbound.io/upbound/provider-aws-sqs:v1.13.0
  runtimeConfigRef:
    name: ${PROVIDER}
EOF

#### Provider AWS EC2
cat <<EOF | kubectl apply -f -
apiVersion: pkg.crossplane.io/v1
kind: Provider
metadata:
  name: provider-aws-ec2
spec:
  package: xpkg.upbound.io/upbound/provider-aws-ec2:v1.13.0
  runtimeConfigRef:
    name: ${PROVIDER}
EOF

#### Provider AWS EKS
cat <<EOF | kubectl apply -f -
apiVersion: pkg.crossplane.io/v1
kind: Provider
metadata:
  name: provider-aws-eks
spec:
  package: xpkg.upbound.io/upbound/provider-aws-eks:v1.16.0
  runtimeConfigRef:
    name: ${PROVIDER}
EOF

#### Provider AWS IAM
cat <<EOF | kubectl apply -f -
apiVersion: pkg.crossplane.io/v1
kind: Provider
metadata:
  name: provider-aws-iam
spec:
  package: xpkg.upbound.io/upbound/provider-aws-iam:v1.15.0
  runtimeConfigRef:
    name: ${PROVIDER}
EOF

#### Provider AWS KMS
cat <<EOF | kubectl apply -f -
apiVersion: pkg.crossplane.io/v1
kind: Provider
metadata:
  name: provider-aws-kms
spec:
  package: xpkg.upbound.io/upbound/provider-aws-kms:v1.14.0
  runtimeConfigRef:
    name: ${PROVIDER}
EOF

#### Provider AWS Lambda
cat <<EOF | kubectl apply -f -
apiVersion: pkg.crossplane.io/v1
kind: Provider
metadata:
  name: provider-aws-lambda
spec:
  package: xpkg.upbound.io/upbound/provider-aws-lambda:v1.13.0
  runtimeConfigRef:
    name: ${PROVIDER}
EOF

#### Provider AWS VPC
cat <<EOF | kubectl apply -f -
apiVersion: pkg.crossplane.io/v1
kind: Provider
metadata:
  name: provider-aws-vpc
spec:
  package: xpkg.upbound.io/upbound/provider-aws-vpc:v1.13.0
  runtimeConfigRef:
    name: ${PROVIDER}  
EOF

#### Provider Kubernetes
cat <<EOF | kubectl apply -f -
apiVersion: pkg.crossplane.io/v1
kind: Provider
metadata:
  name: provider-kubernetes
spec:
  package: xpkg.upbound.io/crossplane-contrib/provider-kubernetes:v0.15.0
  runtimeConfigRef:
    name: ${PROVIDER}  
EOF

#### Provider AWS Scheduler (EventBridge Scheduler)
cat <<EOF | kubectl apply -f -
apiVersion: pkg.crossplane.io/v1
kind: Provider
metadata:
  name: provider-aws-scheduler
spec:
  package: xpkg.upbound.io/upbound/provider-aws-scheduler:v0.50.0
  runtimeConfigRef:
    name: ${PROVIDER}  
EOF

#### Provider Helm
cat <<EOF | kubectl apply -f -
apiVersion: pkg.crossplane.io/v1
kind: Provider
metadata:
  name: provider-helm
spec:
  package: xpkg.upbound.io/crossplane-contrib/provider-helm:v0.21.0
  runtimeConfigRef:
    name: ${PROVIDER}  
EOF

#### Provider AWS CloudWatch
cat <<EOF | kubectl apply -f -
apiVersion: pkg.crossplane.io/v1
kind: Provider
metadata:
  name: provider-aws-cloudwatch
spec:
  package: xpkg.upbound.io/upbound/provider-aws-cloudwatch:v1.17.0
  runtimeConfigRef:
    name: ${PROVIDER}    
EOF

#### Provider AWS SSM
cat <<EOF | kubectl apply -f -
apiVersion: pkg.crossplane.io/v1
kind: Provider
metadata:
  name: provider-aws-ssm
spec:
  package: xpkg.upbound.io/upbound/provider-aws-ssm:v1.18.0
  runtimeConfigRef:
    name: ${PROVIDER}  
EOF

#### Provider AWS AutoScaling (ASG)
cat <<EOF | kubectl apply -f -
apiVersion: pkg.crossplane.io/v1
kind: Provider
metadata:
  name: provider-aws-autoscaling
spec:
  package: xpkg.upbound.io/upbound/provider-aws-autoscaling:v1.18.0
  runtimeConfigRef:
    name: ${PROVIDER}  
EOF

echo ""
echo "🔍 Aguardando instalação dos providers..."
sleep 10

echo ""
echo "📦 Status dos providers instalados:"
kubectl get providers.pkg.crossplane.io | while read line; do
  if [[ "$line" == NAME* ]]; then
    echo "$line STATUS"
  else
    name=$(echo "$line" | awk '{print $1}')
    status=$(kubectl get provider "$name" -o jsonpath='{.status.conditions[?(@.type=="Healthy")].status}')
    if [ "$status" == "True" ]; then
      echo "$line ✅ HEALTHY"
    else
      echo "$line ❌ NOT HEALTHY"
    fi
  fi
done
