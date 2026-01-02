# Kubernetes Manifests

This folder contains Kubernetes configuration files and manifests used in this project.

## 📁 Contents

### `kind-config.yaml`
Kind cluster configuration file that defines:
- Cluster name: `kind-cluster`
- Containerd registry configuration path
- Node configuration with control-plane role
- Volume mounts for TLS certificates

**Key Features:**
- **Registry Configuration**: Uses `/etc/containerd/certs.d` for custom registry certificates
- **CA Certificate Mount**: Mounts `kind-registry-ca.pem` into the node at `/etc/ssl/certs/kind-registry-ca.pem`
- **Node Image**: Uses `kindest/node` with Kubernetes version specified in `cluster.sh`

**Usage:**
This file is automatically used by `scripts/cluster.sh` when creating the cluster:
```bash
./scripts/cluster.sh up
# or
make up
```

## 🔧 Configuration Details

### Containerd Registry Configuration
The cluster is configured to use custom registry certificates via:
```yaml
containerdConfigPatches:
- |-
  [plugins."io.containerd.grpc.v1.cri".registry]
    config_path = "/etc/containerd/certs.d"
```

This allows the cluster nodes to trust the self-signed HTTPS registry.

### Volume Mounts
The CA certificate is mounted into the node:
```yaml
extraMounts:
- hostPath: ./kind-registry-ca.pem
  containerPath: /etc/ssl/certs/kind-registry-ca.pem
```

This ensures the node can verify the registry's TLS certificate.

## 📝 Modifying the Configuration

If you need to customize the cluster configuration:

1. Edit `kind-config.yaml`
2. Recreate the cluster:
   ```bash
   ./scripts/cluster.sh down
   ./scripts/cluster.sh up
   ```

### Common Customizations

**Add more nodes:**
```yaml
nodes:
- role: control-plane
  extraMounts:
  - hostPath: ./kind-registry-ca.pem
    containerPath: /etc/ssl/certs/kind-registry-ca.pem
- role: worker
  extraMounts:
  - hostPath: ./kind-registry-ca.pem
    containerPath: /etc/ssl/certs/kind-registry-ca.pem
```

**Expose additional ports:**
```yaml
nodes:
- role: control-plane
  extraPortMappings:
  - containerPort: 80
    hostPort: 80
    protocol: TCP
  - containerPort: 443
    hostPort: 443
    protocol: TCP
  extraMounts:
  - hostPath: ./kind-registry-ca.pem
    containerPath: /etc/ssl/certs/kind-registry-ca.pem
```

**Change cluster name:**
```yaml
name: my-custom-cluster
```
Note: If you change the cluster name, you'll also need to update `CLUSTER_NAME` in `scripts/cluster.sh`.

## 🔗 Related Files

- `scripts/cluster.sh` - Uses this config to create the cluster
- `kind-registry-ca.pem` - CA certificate mounted into nodes
- `.gitignore` - Ensures certificates are not committed

## 📚 References

- [Kind Configuration Documentation](https://kind.sigs.k8s.io/docs/user/configuration/)
- [Containerd Registry Configuration](https://github.com/containerd/containerd/blob/main/docs/hosts.md)
- [Kind Local Registry Guide](https://kind.sigs.k8s.io/docs/user/local-registry/)

---

**Note**: This configuration is specifically designed for local development with an HTTPS registry using self-signed certificates.

