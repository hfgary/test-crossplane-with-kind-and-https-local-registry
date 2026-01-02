# Crossplane Providers

This directory contains custom Crossplane providers developed for this project.

## 📁 Structure

Each provider should be in its own directory with the following structure:

```
providers/
├── README.md                    # This file
└── provider-<name>/             # Individual provider
    ├── Dockerfile               # Container image definition
    ├── go.mod                   # Go dependencies
    ├── go.sum
    ├── main.go                  # Entry point
    ├── apis/                    # API definitions
    │   └── v1alpha1/
    │       ├── types.go
    │       └── zz_generated.deepcopy.go
    ├── internal/
    │   └── controller/          # Controller logic
    │       └── *.go
    ├── package/
    │   └── crossplane.yaml      # Package metadata
    ├── examples/
    │   └── *.yaml               # Usage examples
    ├── Makefile                 # Build commands
    └── README.md                # Provider documentation
```

## 🚀 Getting Started

### Creating a New Provider

*Coming soon - templates and scaffolding tools will be available in `tools/templates/`*

### Building a Provider

```bash
cd provider-<name>
make build
```

### Testing a Provider

```bash
cd provider-<name>
make test
```

### Pushing to Local Registry

```bash
cd provider-<name>
make push-local
```

## 📚 Resources

- [Crossplane Provider Documentation](https://docs.crossplane.io/latest/concepts/providers/)
- [Building Providers](https://docs.crossplane.io/latest/guides/provider-development/)
- [Provider Development Guide](https://github.com/crossplane/crossplane/blob/master/contributing/guide-provider-development.md)

## 🎯 Development Workflow

1. Create a new provider directory
2. Define your managed resources (CRDs)
3. Implement controller logic
4. Add tests
5. Build and test locally
6. Push to local registry (`kind-registry.local:5005`)
7. Install and test in cluster
8. Publish to production registry (when ready)

## 📝 Notes

- Each provider is independently versioned
- Providers are typically written in Go
- Use the local HTTPS registry for testing before publishing
- See `../infra/README.md` for setting up the local development environment
- Consider using [Upjet](https://github.com/crossplane/upjet) for generating providers from Terraform providers

