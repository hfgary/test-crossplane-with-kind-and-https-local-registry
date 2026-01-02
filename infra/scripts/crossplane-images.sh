#!/bin/bash
set -e

# Variables
CROSSPLANE_VERSION="1.18.2"
LOCAL_REGISTRY="kind-registry.local:5005"

echo "=== Crossplane Image Operations ==="

# Pull from Docker Hub
echo "--- Pulling Crossplane v${CROSSPLANE_VERSION} ---"
docker pull crossplane/crossplane:v${CROSSPLANE_VERSION}

# Tag for Local Registry
echo "--- Tagging for Local Registry ---"
docker tag crossplane/crossplane:v${CROSSPLANE_VERSION} \
  ${LOCAL_REGISTRY}/crossplane:v${CROSSPLANE_VERSION}

# Push to Local HTTPS Registry
echo "--- Pushing to ${LOCAL_REGISTRY} ---"
docker push ${LOCAL_REGISTRY}/crossplane:v${CROSSPLANE_VERSION}

# Verify
echo "--- Verifying Crossplane Image ---"
curl -s --cacert kind-registry-ca.pem \
  https://kind-registry.local:5005/v2/crossplane/tags/list | jq .

echo "✅ Crossplane image operations complete"

