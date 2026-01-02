# Setup Notes

This document contains the original setup notes and manual configuration steps for reference.

## Installing mkcert

```bash
brew install mkcert

# For Firefox
brew install nss

# Install the CA certificate
# Require sudo
JAVA_HOME="" mkcert -install

ls "$(mkcert -CAROOT)"
```

## Generating Certificates

```bash
# Generate the certificates for the domain
JAVA_HOME="" mkcert kind-registry.local

# Rename the CA file to your specific preferred name
cp "$(mkcert -CAROOT)/rootCA.pem" ./kind-registry-ca.pem
```

## Configuring /etc/hosts

```bash
# Require sudo
echo "127.0.0.1 kind-registry.local" | sudo tee -a /etc/hosts
```

## Manual Registry Trust Configuration

```bash
# Configure the internal trust in the node
REGISTRY_DOMAIN="kind-registry.local:5005"
INTERNAL_CA="/etc/ssl/certs/kind-registry-ca.pem"

for node in $(kind get nodes --name cluster); do
  # Create the config directory for this specific registry
  docker exec "${node}" mkdir -p "/etc/containerd/certs.d/${REGISTRY_DOMAIN}"
  
  # Map the CA for the registry domain
  cat <<EOF | docker exec -i "${node}" cp /dev/stdin "/etc/containerd/certs.d/${REGISTRY_DOMAIN}/hosts.toml"
[host."https://${REGISTRY_DOMAIN}"]
  ca = "${INTERNAL_CA}"
EOF
done
```

## Testing the Cluster

```bash
kubectl cluster-info --context kind-cluster
docker push localhost:5005/alpine
```

## Cleanup Commands

```bash
ctlptl delete -f cluster.yaml
kind get clusters
```

---

**Note**: Most of these manual steps are now automated by the `scripts/cluster.sh` script. This document is kept for reference and troubleshooting purposes.

