# Integração do ArgoCD com o Github

export GITHUB_PAT=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
export URL_REPO=https://github.com/rodrigofrs13/poc-eks-crossplane.git
export GITHUB_USERNAME=rodrigofrs13

kubectl apply -f - <<EOF
---
apiVersion: v1
kind: Secret
metadata:
  name: argocd-github-credentials
  namespace: argocd
  labels:
    argocd.argoproj.io/secret-type: repository
type: Opaque
stringData:
  name: argocd-github
  url: ${URL_REPO}
  username: ${GITHUB_USERNAME}
  password: ${GITHUB_PAT}
EOF

