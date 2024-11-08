# O Application 'sqs-queues' permite implantar recursos do Lambda que estão nos diretórios do GITHUB dentro do cluster utilizando o Crossplane.
# https://argo-cd.readthedocs.io/en/stable/user-guide/skip_reconcile/

export URL_REPO=https://github.com/rodrigofrs13/poc-eks-crossplane.git

kubectl apply -f - <<EOF
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: eks-cluster
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
    path: ./cluster-eks
    helm:
      values: |
        clusterName: meu-cluster-eks
        region: us-east-1
        nodeGroups:
          - name: ng-1
            instanceType: t3.medium
            minSize: 1
            maxSize: 3
            desiredCapacity: 2
  destination:
    server: https://kubernetes.default.svc
    namespace: crossplane-system
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
    syncOptions:
    - CreateNamespace=true
EOF