# Infrastructure - Local Development Environment

This directory contains all the infrastructure setup for local Crossplane development with an HTTPS-enabled container registry.

## 📁 Directory Structure

```
infra/
├── Makefile                # Infrastructure-specific commands
├── README.md               # This file
├── scripts/                # Automation scripts
│   ├── cluster.sh          # Cluster and registry management
│   ├── crossplane-images.sh    # Push Crossplane images
│   ├── install-crossplane.sh   # Install Crossplane
│   ├── install-providers.sh    # Install providers
│   ├── list-registry-images.sh # List registry contents
│   └── provider-images.sh      # Push provider images
├── k8s-manifests/          # Kubernetes configurations
│   ├── README.md
│   └── kind-config.yaml    # Kind cluster configuration
└── docs/                   # Infrastructure documentation
    ├── README.md
    ├── images.md           # Image operations reference
    └── setup-notes.md      # Manual setup notes
```

## 🚀 Quick Start

### Complete Setup
```bash
# Run everything in one command
make setup
```

This will:
1. Create Kind cluster and HTTPS registry
2. Push Crossplane and provider images
3. Install Crossplane with CA certificate
4. Install providers

### Step-by-Step Setup
```bash
# 1. Create cluster and registry
make up

# 2. Push images to registry
make push-all

# 3. Install Crossplane
make install-crossplane

# 4. Install providers
make install-providers
```

## 🛠️ Available Commands

Run `make help` to see all available commands.

### Cluster Management
- `make up` - Create Kind cluster and HTTPS registry
- `make down` - Destroy cluster and registry
- `make status` - Show status of cluster and registry
- `make verify` - Verify registry connectivity
- `make fix` - Fix registry network issues

### Image Management
- `make push-crossplane` - Push Crossplane image to local registry
- `make push-providers` - Push provider images to local registry
- `make push-all` - Push all images
- `make list-images` - List all images in registry

### Crossplane Management
- `make install-crossplane` - Install Crossplane with CA certificate
- `make install-providers` - Install Crossplane providers
- `make install-all` - Install both Crossplane and providers

## 📋 Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [kind](https://kind.sigs.k8s.io/docs/user/quick-start/#installation)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Helm](https://helm.sh/docs/intro/install/)
- [mkcert](https://github.com/FiloSottile/mkcert#installation)
- [jq](https://stedolan.github.io/jq/download/)

### Initial Setup

1. **Install mkcert**:
   ```bash
   # macOS
   brew install mkcert
   brew install nss  # For Firefox support
   
   # Install CA certificate
   JAVA_HOME="" mkcert -install
   ```

2. **Configure /etc/hosts**:
   ```bash
   echo "127.0.0.1 kind-registry.local" | sudo tee -a /etc/hosts
   ```

## 🏗️ What This Sets Up

- **Kind cluster** (`kind-cluster`) with containerd registry configuration
- **HTTPS registry** (`kind-registry.local:5005`) with self-signed certificates
- **Crossplane** with CA certificate mounted for registry trust
- **AWS Providers** (family-aws and aws-s3) from local registry

## 📚 Documentation

- [`docs/setup-notes.md`](docs/setup-notes.md) - Manual setup steps (for reference)
- [`docs/images.md`](docs/images.md) - Image operations reference
- [`k8s-manifests/README.md`](k8s-manifests/README.md) - Kubernetes configuration details

## 🐛 Troubleshooting

### Registry connectivity issues
```bash
make verify  # Test connectivity
make fix     # Fix network issues
```

### TLS certificate errors
```bash
make down    # Clean up
make up      # Recreate with fresh certificates
```

### Provider installation failures
```bash
# Check Crossplane logs
kubectl logs -n crossplane-system -l app=crossplane

# Check provider status
kubectl describe provider provider-aws-s3
```

## 🔒 Security

This setup uses self-signed TLS certificates for local development:
- Certificates are generated locally with mkcert
- Private keys and certificates are in `.gitignore`
- Each developer generates their own certificates

## 🎯 Purpose

This infrastructure directory is separate from the actual Crossplane artifacts (functions, providers, configurations) that you'll develop. It provides:

- Isolated local development environment
- HTTPS registry for testing packages
- Automated setup and teardown
- Consistent development experience

## 📖 Related Documentation

See the main repository README for the overall monorepo structure and how this infrastructure fits into the larger development workflow.

