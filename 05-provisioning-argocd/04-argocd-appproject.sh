# O AppProject 'applications-project' permite que um usuário não administrador implante recursos na namespace ArgoCD dentro do cluster.
# https://argo-cd.readthedocs.io/en/stable/user-guide/projects/

export URL_REPO=https://github.com/rodrigofrs13/poc-eks-crossplane.git

kubectl apply -f - <<EOF
apiVersion: argoproj.io/v1alpha1
kind: AppProject
metadata:
  name: applications-project
  namespace: argocd
  finalizers:
    - resources-finalizer.argocd.argoproj.io
spec:
  description: Project for argocd applicatons
  sourceRepos:
  - ${URL_REPO}

  #
  # Allow this project to deploy only to 'argocd' namespace
  #
  destinations:
  - namespace: crossplane-system
    server: https://kubernetes.default.svc

  # can deploy any SQS resources
  clusterResourceWhitelist:
  - group: '*'
    kind: '*'    

EOF

