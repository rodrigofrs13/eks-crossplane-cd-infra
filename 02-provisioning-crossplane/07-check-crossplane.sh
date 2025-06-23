#!/usr/bin/env bash
set -euo pipefail

NAMESPACE="crossplane-system"

echo "🔍 Verificando instalação do Crossplane..."

# 1. Verifica se o deployment principal do Crossplane está pronto
if kubectl rollout status deployment/crossplane -n ${NAMESPACE} --timeout=60s; then
  echo "✅ Crossplane core está pronto."
else
  echo "❌ Crossplane core com problemas."
  exit 1
fi

echo "📦 Verificando Providers instalados..."

# 2. Lista todos os providers instalados e verifica status
PROVIDERS=$(kubectl get providers.pkg.crossplane.io -o jsonpath='{range .items[*]}{.metadata.name}{"\n"}{end}')

for p in $PROVIDERS; do
  STATUS=$(kubectl get providers.pkg.crossplane.io $p -o jsonpath='{.status.conditions[?(@.type=="Healthy")].status}')
  INSTALLED=$(kubectl get providers.pkg.crossplane.io $p -o jsonpath='{.status.conditions[?(@.type=="Installed")].status}')
  
  if [[ "$STATUS" == "True" && "$INSTALLED" == "True" ]]; then
    echo "✅ Provider '$p' está INSTALADO e HEALTHY."
  else
    echo "❌ Problema no Provider '$p' — Installed: $INSTALLED, Healthy: $STATUS"
  fi
done

# 3. Verifica se os pods estão rodando no namespace do Crossplane
echo "🚦 Checando pods em ${NAMESPACE}..."

NOT_READY=$(kubectl get pods -n ${NAMESPACE} --no-headers | grep -v 'Running\|Completed' || true)

if [[ -z "$NOT_READY" ]]; then
  echo "✅ Todos os pods no namespace ${NAMESPACE} estão em bom estado."
else
  echo "⚠️ Alguns pods não estão prontos:"
  echo "$NOT_READY"
fi

# 4. Verifica se há DeploymentRuntimeConfig aplicado
echo "📘 Verificando DeploymentRuntimeConfigs..."

DRCS=$(kubectl get deploymentruntimeconfigs.pkg.crossplane.io -o name || true)

if [[ -z "$DRCS" ]]; then
  echo "⚠️ Nenhum DeploymentRuntimeConfig encontrado."
else
  echo "✅ Encontrado(s):"
  echo "$DRCS"
fi

echo ""
echo "✅ Verificação concluída!"
