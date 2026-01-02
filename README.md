# Crossplane Development Monorepo

A monorepo for developing Crossplane functions, providers, and configurations with a complete local development environment featuring an HTTPS-enabled container registry.

## 📁 Repository Structure

```
.
├── .gitignore              # Git ignore rules (protects sensitive files)
├── Makefile                # Root-level build orchestration
├── README.md               # This file
├── Tiltfile                # Tilt configuration for development
│
├── infra/                  # Local development infrastructure
│   ├── Makefile            # Infrastructure commands
│   ├── README.md           # Infrastructure documentation
│   ├── scripts/            # Setup and management scripts
│   ├── k8s-manifests/      # Kind cluster configuration
│   └── docs/               # Infrastructure documentation
│
├── functions/              # Crossplane Composition Functions (coming soon)
│   └── README.md
│
├── providers/              # Custom Crossplane Providers (coming soon)
│   └── README.md
│
├── configurations/         # Crossplane Configuration Packages (coming soon)
│   └── README.md
│
├── packages/               # Shared/reusable packages (coming soon)
│   └── README.md
│
├── examples/               # End-to-end examples (coming soon)
│   └── README.md
│
├── tools/                  # Development tools & utilities (coming soon)
│   └── README.md
│
└── working-memory/         # Development notes and planning
    ├── README.md
    ├── MONOREPO_STRUCTURE.md  # Detailed monorepo plan
    ├── GIT_COMMIT_GUIDE.md
    ├── REGISTRY_FIX.md
    ├── SECURITY.md
    └── SETUP_COMPLETE.md
```

## 📂 Directory Descriptions

### `/infra` - Local Development Infrastructure
Complete local development environment with Kind cluster and HTTPS registry. This is where you set up your development environment before building Crossplane artifacts.

**Key features:**
- Kind cluster with Kubernetes
- HTTPS registry with self-signed certificates
- Automated setup scripts
- Crossplane installation

See [`infra/README.md`](infra/README.md) for detailed documentation.

### `/functions` - Composition Functions
Directory for developing Crossplane composition functions (Go, Python, etc.). Each function is self-contained with its own build, test, and package configuration.

*Coming soon - directory structure ready for your first function.*

### `/providers` - Custom Providers
Directory for developing custom Crossplane providers. Each provider is independently buildable and publishable.

*Coming soon - directory structure ready for your first provider.*

### `/configurations` - Configuration Packages
Directory for Crossplane configuration packages containing compositions, XRDs, and function references.

*Coming soon - directory structure ready for your first configuration.*

### `/packages` - Shared Code
Shared and reusable code across functions, providers, and configurations.

*Coming soon.*

### `/examples` - Examples
End-to-end examples demonstrating how to use the functions, providers, and configurations together.

*Coming soon.*

### `/tools` - Development Tools
Development tools, scripts, templates, and CI/CD configurations.

*Coming soon.*

### `/working-memory` - Development Notes
Development notes, troubleshooting guides, and planning documents. Contains the detailed monorepo structure plan and historical context.

## 🚀 Quick Start

### Set Up Local Development Environment

```bash
# Complete setup (cluster + registry + Crossplane + providers)
make up

# Or use the comprehensive setup command
cd infra
make setup
```

This will:
1. Create a Kind cluster with HTTPS registry
2. Push Crossplane and provider images to the registry
3. Install Crossplane with CA certificate
4. Install AWS providers

### Verify Setup

```bash
# Check cluster and registry status
make status

# Check Crossplane installation
kubectl get deployments -n crossplane-system

# Check providers
kubectl get providers
```

## 🎯 Current Status

**Phase 1 Complete**: Infrastructure reorganized into `infra/` directory

**Next Steps**:
- Create your first Crossplane function in `functions/`
- Create your first configuration in `configurations/`
- Set up templates in `tools/templates/`

See [`working-memory/MONOREPO_STRUCTURE.md`](working-memory/MONOREPO_STRUCTURE.md) for the complete monorepo plan.

## 📚 Documentation

### Infrastructure & Setup
- **Infrastructure Guide**: [`infra/README.md`](infra/README.md) - Complete infrastructure documentation
- **Setup Notes**: [`infra/docs/setup-notes.md`](infra/docs/setup-notes.md) - Manual setup steps
- **Kubernetes Config**: [`infra/k8s-manifests/README.md`](infra/k8s-manifests/README.md) - Kind configuration

### Development & Planning
- **Monorepo Structure**: [`working-memory/MONOREPO_STRUCTURE.md`](working-memory/MONOREPO_STRUCTURE.md) - Complete monorepo plan
- **Troubleshooting**: [`working-memory/REGISTRY_FIX.md`](working-memory/REGISTRY_FIX.md) - Registry issues
- **Security**: [`working-memory/SECURITY.md`](working-memory/SECURITY.md) - Security guidelines
- **Git Guide**: [`working-memory/GIT_COMMIT_GUIDE.md`](working-memory/GIT_COMMIT_GUIDE.md) - Commit guidelines

## 🛠️ Development Workflow

### Working with Infrastructure

```bash
# Start development environment
make up

# Stop development environment
make down

# Check status
make status
```

For more infrastructure commands, see [`infra/README.md`](infra/README.md) or run:
```bash
cd infra
make help
```

### Creating Crossplane Artifacts

*Coming soon - templates and workflows for creating functions, providers, and configurations.*

## 🏗️ Monorepo Structure

This repository follows a monorepo structure where:

- **Infrastructure** (`infra/`) is isolated from Crossplane artifacts
- **Functions, Providers, Configurations** are independently developed and versioned
- **Shared tooling** ensures consistent development experience
- **Examples** demonstrate end-to-end usage

See the [Monorepo Structure Plan](working-memory/MONOREPO_STRUCTURE.md) for detailed information.

## 🤝 Contributing

1. Set up your local development environment (see Quick Start)
2. Review the security guidelines in [`working-memory/SECURITY.md`](working-memory/SECURITY.md)
3. Follow the git commit guide in [`working-memory/GIT_COMMIT_GUIDE.md`](working-memory/GIT_COMMIT_GUIDE.md)
4. Ensure no sensitive files are committed (check `.gitignore`)

## 📄 License

This project is for local development and testing purposes.
