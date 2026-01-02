#!/bin/bash
set -e

# Variables
FAMILY_PROVIDER_VERSION="v1.18.2"
S3_PROVIDER_VERSION="v1.18.2"
LOCAL_REGISTRY="kind-registry.local:5005"

echo "=== Provider Image Operations ==="

# ============================================
# AWS Family Provider
# ============================================
echo "--- Pulling AWS Family Provider ${FAMILY_PROVIDER_VERSION} ---"
docker pull xpkg.upbound.io/upbound/provider-family-aws:${FAMILY_PROVIDER_VERSION}

echo "--- Tagging AWS Family Provider ---"
docker tag xpkg.upbound.io/upbound/provider-family-aws:${FAMILY_PROVIDER_VERSION} \
  ${LOCAL_REGISTRY}/upbound/provider-family-aws:${FAMILY_PROVIDER_VERSION}

echo "--- Pushing AWS Family Provider ---"
docker push ${LOCAL_REGISTRY}/upbound/provider-family-aws:${FAMILY_PROVIDER_VERSION}

# ============================================
# AWS S3 Provider
# ============================================
echo "--- Pulling AWS S3 Provider ${S3_PROVIDER_VERSION} ---"
docker pull xpkg.upbound.io/upbound/provider-aws-s3:${S3_PROVIDER_VERSION}

echo "--- Tagging AWS S3 Provider ---"
docker tag xpkg.upbound.io/upbound/provider-aws-s3:${S3_PROVIDER_VERSION} \
  ${LOCAL_REGISTRY}/upbound/provider-aws-s3:${S3_PROVIDER_VERSION}

echo "--- Pushing AWS S3 Provider ---"
docker push ${LOCAL_REGISTRY}/upbound/provider-aws-s3:${S3_PROVIDER_VERSION}

# ============================================
# Verify All Providers
# ============================================
echo "--- Verifying Provider Images ---"
echo "Registry Catalog:"
curl -s --cacert kind-registry-ca.pem \
  https://kind-registry.local:5005/v2/_catalog | jq .

echo ""
echo "AWS Family Provider Tags:"
curl -s --cacert kind-registry-ca.pem \
  https://kind-registry.local:5005/v2/upbound/provider-family-aws/tags/list | jq .

echo ""
echo "AWS S3 Provider Tags:"
curl -s --cacert kind-registry-ca.pem \
  https://kind-registry.local:5005/v2/upbound/provider-aws-s3/tags/list | jq .

echo "✅ Provider image operations complete"

