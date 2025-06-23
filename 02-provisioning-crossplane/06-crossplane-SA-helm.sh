cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ServiceAccount
metadata:
  name: provider-helm
  namespace: crossplane-system
  annotations:
    eks.amazonaws.com/role-arn: arn:aws:iam::xxx:role/control-plane-admin
EOF

##  kk get sa -n crossplane-system
## 