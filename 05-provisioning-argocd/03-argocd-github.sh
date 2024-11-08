# Integração do ArgoCD com o Github

export GITHUB_PAT=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
export URL_REPO=https://github.com/rodrigofrs13/eks-crossplane-cd-resources.git
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

