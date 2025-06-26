cat <<EOF | kubectl apply -f -
apiVersion: pkg.crossplane.io/v1beta1
kind: DeploymentRuntimeConfig
metadata:
  name: irsa-providerconfig
spec:
  deploymentTemplate:
    spec:
      replicas: 3
      selector: {}
      template:
        spec:
          containers:
            - name: package-runtime
              args:
              - --debug
          securityContext:
            fsGroup: 2000
  serviceAccountTemplate:
    metadata:
      annotations:
        eks.amazonaws.com/role-arn: arn:aws:iam::xxx:role/control-plane-admin
EOF

# kk get DeploymentRuntimeConfig