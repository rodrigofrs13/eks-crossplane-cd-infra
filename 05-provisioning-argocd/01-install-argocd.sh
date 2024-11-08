# This will create a new namespace, argocd, where Argo CD services and application resources will live.
# Ajustar o jq da linha 9

#kubectl config use-context controlplane
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
echo "Waiting for Argo CD to be ready..."
sleep 120
