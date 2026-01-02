#!/bin/bash
set -e

# Variables
CROSSPLANE_VERSION="1.18.2"
LOCAL_REGISTRY="kind-registry.local:5005"
NAMESPACE="crossplane-system"

echo "=== Installing Crossplane ==="

# Create ConfigMap with CA certificate for registry TLS
echo "--- Creating CA certificate ConfigMap ---"
if [ ! -f "kind-registry-ca.pem" ]; then
  echo "❌ Error: kind-registry-ca.pem not found"
  echo "Make sure you're running this from the project root directory"
  exit 1
fi

kubectl create namespace ${NAMESPACE} --dry-run=client -o yaml | kubectl apply -f -

kubectl create configmap custom-certs-cm \
  --from-file=cert.pem=kind-registry-ca.pem \
  -n ${NAMESPACE} \
  --dry-run=client -o yaml | kubectl apply -f -

echo "✅ CA certificate ConfigMap created"

# Check if Crossplane is already installed
if helm list -n ${NAMESPACE} | grep -q crossplane; then
  echo "⚠️  Crossplane is already installed"
  read -p "Do you want to upgrade? (y/n) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "--- Upgrading Crossplane ---"
    helm upgrade crossplane crossplane-stable/crossplane \
      --namespace ${NAMESPACE} \
      --version ${CROSSPLANE_VERSION} \
      --set image.repository=${LOCAL_REGISTRY}/crossplane \
      --set-json 'extraVolumeMountsCrossplane=[{"name":"custom-certs","mountPath":"/etc/ssl/certs/cert.pem","subPath":"cert.pem"}]' \
      --set-json 'extraVolumesCrossplane=[{"name":"custom-certs","configMap":{"name":"custom-certs-cm"}}]'
  else
    echo "Skipping installation"
    exit 0
  fi
else
  echo "--- Installing Crossplane v${CROSSPLANE_VERSION} ---"
  helm install crossplane crossplane-stable/crossplane \
    --namespace ${NAMESPACE} \
    --create-namespace \
    --version ${CROSSPLANE_VERSION} \
    --set image.repository=${LOCAL_REGISTRY}/crossplane \
    --set-json 'extraVolumeMountsCrossplane=[{"name":"custom-certs","mountPath":"/etc/ssl/certs/cert.pem","subPath":"cert.pem"}]' \
    --set-json 'extraVolumesCrossplane=[{"name":"custom-certs","configMap":{"name":"custom-certs-cm"}}]'
fi

# Wait for Crossplane to be ready
echo "--- Waiting for Crossplane to be ready ---"
kubectl wait --for=condition=available --timeout=300s \
  deployment/crossplane -n ${NAMESPACE}

# Verify installation
echo "--- Verifying Crossplane Installation ---"
kubectl get deployments -n ${NAMESPACE}
kubectl get pods -n ${NAMESPACE}

echo "✅ Crossplane installation complete"

