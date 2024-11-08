# O Application 'sqs-queues' permite implantar recursos do SQS que estão nos diretórios do GITHUB dentro do cluster utilizando o Crossplane.
# https://argo-cd.readthedocs.io/en/stable/user-guide/skip_reconcile/

export URL_REPO=https://github.com/rodrigofrs13/poc-eks-crossplane.git

kubectl apply -f - <<EOF
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: sqs-queues
  namespace: argocd
  finalizers:
    - resources-finalizer.argocd.argoproj.io   
spec:
  project: applications-project
  source:
    repoURL: ${URL_REPO}
    targetRevision: HEAD
    path: ./sqs-queues
  destination:
    server: https://kubernetes.default.svc
    namespace: crossplane-system
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
    syncOptions:
    - SyncWaveOrder=true
    retry:
      limit: 1
      backoff:
        duration: 5s 
        factor: 2 
        maxDuration: 1m
EOF