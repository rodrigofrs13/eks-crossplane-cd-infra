#!/bin/bash

# Crossplane Installation Script - v1.20.0
# Documentation: https://docs.crossplane.io/v1.20/software/install/
# 
# ⚠️  IMPORTANT CHANGES IN v1.20.0:
# - Default registry changed to xpkg.crossplane.io (from xpkg.upbound.io)
# - Realtime compositions enabled by default (Beta)
# - Several flag name changes (see comments below)

set -e

echo "🚀 Installing Crossplane..."

# Add Crossplane Helm repository
echo "📦 Adding Crossplane Helm repository..."
helm repo add crossplane-stable https://charts.crossplane.io/stable
helm repo update

# Install/Upgrade Crossplane
echo "⚙️ Installing Crossplane with optimized settings..."
helm upgrade --install crossplane crossplane-stable/crossplane \
  --namespace crossplane-system \
  --create-namespace \
  --version 1.20.0 \
  --set args='{"--enable-realtime-compositions=true"}' \
  --set "provider.packages.reconciliationInterval=1m" \
  --set "cache.enabled=true" \
  --set "cache.ttl=5m" \
  --set "metrics.enabled=true" \
  --set "resourcesCrossplane.limits.cpu=1000m" \
  --set "resourcesCrossplane.limits.memory=1Gi" \
  --set "resourcesCrossplane.requests.cpu=100m" \
  --set "resourcesCrossplane.requests.memory=128Mi" \
  --wait \
  --timeout=5m

echo "✅ Crossplane installation completed!"

# Wait for pods to be ready
echo "⏳ Waiting for Crossplane pods to be ready..."
kubectl wait --for=condition=Ready pod -l app=crossplane -n crossplane-system --timeout=300s

# Display installation status
echo "📊 Crossplane installation status:"
kubectl get pods -n crossplane-system
echo ""

# Display Crossplane version
echo "🔍 Crossplane version:"
kubectl get deployment crossplane -n crossplane-system -o jsonpath='{.spec.template.spec.containers[0].image}' && echo ""

echo "🎉 Crossplane v1.20.0 is ready!"
echo ""
echo "🚨 BREAKING CHANGES IN v1.20.0:"
echo "  • Default registry: xpkg.crossplane.io (changed from xpkg.upbound.io)"
echo "  • Realtime compositions: enabled by default (better performance)"
echo "  • New flag names: --enable-webhooks (was --webhook-enabled)"
echo ""
echo "📋 Useful commands:"
echo "  • Check pods: kubectl get pods -n crossplane-system"
echo "  • Follow logs: kubectl logs -f -n crossplane-system deployment/crossplane"
echo "  • Get values: helm get values crossplane -n crossplane-system"
echo "  • Check CRDs: kubectl get crd | grep crossplane"
echo "  • Verify realtime composition: kubectl logs -n crossplane-system deployment/crossplane | grep realtime"