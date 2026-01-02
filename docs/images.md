
```
curl -s --cacert kind-registry-ca.pem https://kind-registry.local:5005/v2/_catalog | jq .
curl -s --cacert kind-registry-ca.pem \
  https://kind-registry.local:5005/v2/crossplane/tags/list | jq .


# Variables
VERSION="1.18.2"
LOCAL_REGISTRY="kind-registry.local:5005"

# 1. Pull from Public Docker Hub
docker pull crossplane/crossplane:v$VERSION

# 2. Tag for Local Registry
docker tag crossplane/crossplane:v$VERSION $LOCAL_REGISTRY/crossplane:v$VERSION

# 3. Push to Local HTTPS Registry
docker push $LOCAL_REGISTRY/crossplane:v$VERSION


helm install crossplane crossplane-stable/crossplane \
  --namespace crossplane-system \
  --create-namespace \
  --version 1.18.2 \
  --set image.repository=$LOCAL_REGISTRY/crossplane


```