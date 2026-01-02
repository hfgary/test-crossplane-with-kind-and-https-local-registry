#!/bin/bash
set -e

# Variables
FAMILY_PROVIDER_VERSION="v1.18.2"
S3_PROVIDER_VERSION="v1.18.2"
LOCAL_REGISTRY="kind-registry.local:5005"

echo "=== Installing Crossplane Providers ==="

# Check if Crossplane is installed
if ! kubectl get namespace crossplane-system &> /dev/null; then
  echo "❌ Error: Crossplane is not installed. Run install-crossplane.sh first."
  exit 1
fi

# ============================================
# Install AWS Family Provider
# ============================================
echo "--- Installing AWS Family Provider ---"
cat <<EOF | kubectl apply -f -
apiVersion: pkg.crossplane.io/v1
kind: Provider
metadata:
  name: provider-family-aws
spec:
  package: ${LOCAL_REGISTRY}/upbound/provider-family-aws:${FAMILY_PROVIDER_VERSION}
  packagePullPolicy: IfNotPresent
  skipDependencyResolution: true
EOF

# ============================================
# Install AWS S3 Provider
# ============================================
echo "--- Installing AWS S3 Provider ---"
cat <<EOF | kubectl apply -f -
apiVersion: pkg.crossplane.io/v1
kind: Provider
metadata:
  name: provider-aws-s3
spec:
  package: ${LOCAL_REGISTRY}/upbound/provider-aws-s3:${S3_PROVIDER_VERSION}
  packagePullPolicy: IfNotPresent
  skipDependencyResolution: true
EOF

# ============================================
# Wait for Providers to be Ready
# ============================================
echo "--- Waiting for Providers to be Ready (this may take a few minutes) ---"

echo "Waiting for AWS Family Provider..."
kubectl wait --for=condition=healthy --timeout=300s provider/provider-family-aws || true

echo "Waiting for AWS S3 Provider..."
kubectl wait --for=condition=healthy --timeout=300s provider/provider-aws-s3 || true

# ============================================
# Verify Installation
# ============================================
echo "--- Provider Status ---"
kubectl get providers

echo ""
echo "--- Provider Pods ---"
kubectl get pods -n crossplane-system

echo ""
echo "--- Provider Details ---"
kubectl describe provider provider-family-aws | grep -A 5 "Status:"
kubectl describe provider provider-aws-s3 | grep -A 5 "Status:"

echo "✅ Provider installation complete"

