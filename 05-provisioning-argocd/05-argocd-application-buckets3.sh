# O Application 'sqs-queues' permite implantar recursos do Lambda que estão nos diretórios do GITHUB dentro do cluster utilizando o Crossplane.
# https://argo-cd.readthedocs.io/en/stable/user-guide/skip_reconcile/

export URL_REPO=https://github.com/rodrigofrs13/poc-eks-crossplane.git

kubectl apply -f - <<EOF
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: bucket-s3
  namespace: argocd
  # labels:
  #   crossplane.jonashackt.io: infrastructure
  finalizers:
    - resources-finalizer.argocd.argoproj.io
spec:
  project: applications-project
  source:
    repoURL: ${URL_REPO}
    targetRevision: HEAD
    path: ./bucket-s3
  destination:
    server: https://kubernetes.default.svc
    namespace: crossplane-system
  syncPolicy:
    automated:
      prune: true    
    retry:
      limit: 5
      backoff:
        duration: 5s 
        factor: 2 
        maxDuration: 1m
EOF