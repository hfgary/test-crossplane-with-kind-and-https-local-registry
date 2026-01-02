# Local Crossplane Development with HTTPS Registry

A complete local development environment for Crossplane with an HTTPS-enabled container registry using self-signed certificates.

## 📁 Repository Structure

```
.
├── .gitignore              # Git ignore rules (protects sensitive files)
├── Makefile                # Build automation and shortcuts
├── README.md               # This file
├── Tiltfile                # Tilt configuration for development
│
├── docs/                   # Documentation and reference materials
│   ├── README.md           # Documentation index
│   ├── images.md           # Image operations reference
│   └── setup-notes.md      # Manual setup notes
│
├── k8s-manifests/          # Kubernetes configuration files
│   ├── README.md           # Kubernetes config documentation
│   └── kind-config.yaml    # Kind cluster configuration
│
├── scripts/                # Automation scripts
│   ├── cluster.sh          # Cluster and registry management
│   ├── crossplane-images.sh    # Push Crossplane images
│   ├── install-crossplane.sh   # Install Crossplane
│   ├── install-providers.sh    # Install Crossplane providers
│   ├── list-registry-images.sh # List registry contents
│   └── provider-images.sh      # Push provider images
│
└── working-memory/         # Development notes and troubleshooting
    ├── README.md           # Working memory index
    ├── GIT_COMMIT_GUIDE.md # Git commit guidelines
    ├── REGISTRY_FIX.md     # Registry troubleshooting
    ├── SECURITY.md         # Security guidelines
    └── SETUP_COMPLETE.md   # Setup completion guide
```

## 📂 Folder Descriptions

### `/docs`
Reference documentation and manual setup instructions. Contains detailed guides for understanding the underlying setup and performing manual operations when needed.

### `/k8s-manifests`
Kubernetes configuration files, including the Kind cluster configuration with registry trust settings and certificate mounts.

### `/scripts`
Executable automation scripts for cluster management, image operations, and Crossplane installation. These scripts automate the manual steps documented in `/docs`.

### `/working-memory`
Development notes, troubleshooting guides, and setup documentation created during the project development. Useful for understanding fixes applied and security considerations.

## 🚀 Quick Start

```bash
# 1. Create cluster and registry
make up

# 2. Push images to registry
./scripts/crossplane-images.sh
./scripts/provider-images.sh

# 3. Install Crossplane
./scripts/install-crossplane.sh

# 4. Install providers
./scripts/install-providers.sh
```

## 📚 Documentation

For detailed information, see:
- **Setup Guide**: [`docs/setup-notes.md`](docs/setup-notes.md)
- **Kubernetes Config**: [`k8s-manifests/README.md`](k8s-manifests/README.md)
- **Troubleshooting**: [`working-memory/REGISTRY_FIX.md`](working-memory/REGISTRY_FIX.md)
- **Security**: [`working-memory/SECURITY.md`](working-memory/SECURITY.md)
