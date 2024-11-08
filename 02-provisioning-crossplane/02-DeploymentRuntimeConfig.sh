# Alterar na linha 24 com a role 

cat <<EOF | kubectl apply -f -
apiVersion: pkg.crossplane.io/v1beta1
kind: DeploymentRuntimeConfig
metadata:
  name: irsa-providerconfig
spec:
  deploymentTemplate:
    spec:
      replicas: 1
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
        eks.amazonaws.com/role-arn: arn:aws:iam::246732148991:role/control-plane-admin
EOF

