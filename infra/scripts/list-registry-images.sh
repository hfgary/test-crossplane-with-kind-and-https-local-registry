#!/bin/bash
set -e

# Variables
LOCAL_REGISTRY="kind-registry.local:5005"
REGISTRY_URL="https://${LOCAL_REGISTRY}"
CA_CERT="kind-registry-ca.pem"

# Check if CA certificate exists
if [ ! -f "${CA_CERT}" ]; then
  echo "❌ Error: CA certificate '${CA_CERT}' not found" >&2
  echo "Make sure you're running this from the project root directory" >&2
  exit 1
fi

# Get catalog
CATALOG=$(curl -s --cacert ${CA_CERT} ${REGISTRY_URL}/v2/_catalog)

# Build JSON array of images with their tags
IMAGES_JSON="[]"

echo "${CATALOG}" | jq -r '.repositories[]' | while read -r repo; do
  TAGS=$(curl -s --cacert ${CA_CERT} ${REGISTRY_URL}/v2/${repo}/tags/list)
  
  # Create image object
  IMAGE_OBJ=$(jq -n \
    --arg repo "$repo" \
    --argjson tags "$(echo ${TAGS} | jq '.tags // []')" \
    '{repository: $repo, tags: $tags}')
  
  # Append to array
  IMAGES_JSON=$(echo "${IMAGES_JSON}" | jq --argjson img "${IMAGE_OBJ}" '. += [$img]')
  
  # Output intermediate result to temp file
  echo "${IMAGES_JSON}" > /tmp/registry-images.json
done

# Read final result and create complete JSON
FINAL_JSON=$(jq -n \
  --arg registry "${LOCAL_REGISTRY}" \
  --argjson images "$(cat /tmp/registry-images.json 2>/dev/null || echo '[]')" \
  '{registry: $registry, images: $images}')

# Clean up temp file
rm -f /tmp/registry-images.json

# Pretty print with jq
echo "${FINAL_JSON}" | jq .

