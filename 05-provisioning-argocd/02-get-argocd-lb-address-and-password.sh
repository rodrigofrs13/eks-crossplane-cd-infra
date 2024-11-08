
ARGOCD_PWD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
#echo export ARGOCD_PWD=\"$ARGOCD_PWD\" >> ~/.bashrc
echo "Argo CD admin password: $ARGOCD_PWD"


export ARGOCD_SERVER=$(kubectl get svc argocd-server -n argocd -o json | jq-windows-amd64.exe --raw-output '.status.loadBalancer.ingress[0].hostname')
#echo export ARGOCD_SERVER=\"$ARGOCD_SERVER\" >> ~/.bashrc
echo "Argo CD URL: https://$ARGOCD_SERVER"

