# Crossplane Configurations

This directory contains Crossplane configuration packages (compositions and XRDs) developed for this project.

## 📁 Structure

Each configuration should be in its own directory with the following structure:

```
configurations/
├── README.md                    # This file
└── platform-<name>/             # Individual configuration
    ├── crossplane.yaml          # Package metadata
    ├── compositions/            # Composition definitions
    │   ├── database.yaml
    │   ├── network.yaml
    │   └── cluster.yaml
    ├── definitions/             # XRDs (CompositeResourceDefinitions)
    │   ├── xdatabase.yaml
    │   ├── xnetwork.yaml
    │   └── xcluster.yaml
    ├── functions/               # Function references
    │   └── function-refs.yaml
    ├── examples/                # Example claims
    │   ├── database-claim.yaml
    │   └── network-claim.yaml
    └── README.md                # Configuration documentation
```

## 🚀 Getting Started

### Creating a New Configuration

*Coming soon - templates and scaffolding tools will be available in `tools/templates/`*

### Building a Configuration

```bash
cd platform-<name>
crossplane build configuration
```

### Pushing to Local Registry

```bash
cd platform-<name>
crossplane build configuration
crossplane push configuration kind-registry.local:5005/platform-<name>:v0.1.0
```

### Installing in Cluster

```bash
kubectl apply -f - <<EOF
apiVersion: pkg.crossplane.io/v1
kind: Configuration
metadata:
  name: platform-<name>
spec:
  package: kind-registry.local:5005/platform-<name>:v0.1.0
EOF
```

## 📚 Resources

- [Crossplane Configuration Documentation](https://docs.crossplane.io/latest/concepts/packages/)
- [Compositions](https://docs.crossplane.io/latest/concepts/compositions/)
- [Composite Resource Definitions (XRDs)](https://docs.crossplane.io/latest/concepts/composite-resource-definitions/)
- [Composition Functions](https://docs.crossplane.io/latest/concepts/composition-functions/)

## 🎯 Development Workflow

1. Create a new configuration directory
2. Define your XRDs (composite resource definitions)
3. Create compositions that implement the XRDs
4. Reference any composition functions needed
5. Add example claims
6. Build the configuration package
7. Push to local registry (`kind-registry.local:5005`)
8. Install and test in cluster
9. Publish to production registry (when ready)

## 📝 Configuration Types

### Platform Configurations
Complete platform setups that bundle multiple resources together (e.g., `platform-aws`, `platform-gcp`).

### Component Configurations
Reusable components that can be composed into larger platforms (e.g., `config-database`, `config-network`).

## 🔧 Best Practices

- Keep XRDs focused and composable
- Use composition functions for complex logic
- Provide comprehensive examples
- Document all configuration options
- Version configurations independently
- Test configurations thoroughly before publishing

## 📝 Notes

- Each configuration is independently versioned
- Configurations are pure YAML (no code)
- Use composition functions for complex transformations
- See `../infra/README.md` for setting up the local development environment
- See `../functions/README.md` for developing composition functions

