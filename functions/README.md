# Crossplane Composition Functions

This directory contains Crossplane composition functions developed for this project.

## 📁 Structure

Each function should be in its own directory with the following structure:

```
functions/
├── README.md                    # This file
└── function-<name>/             # Individual function
    ├── Dockerfile               # Container image definition
    ├── go.mod                   # Go dependencies (or requirements.txt for Python)
    ├── go.sum
    ├── main.go                  # Entry point
    ├── fn.go                    # Function logic
    ├── package/
    │   └── crossplane.yaml      # Package metadata
    ├── examples/
    │   └── composition.yaml     # Usage examples
    ├── tests/
    │   └── *_test.go            # Tests
    ├── Makefile                 # Build commands
    └── README.md                # Function documentation
```

## 🚀 Getting Started

### Creating a New Function

*Coming soon - templates and scaffolding tools will be available in `tools/templates/`*

### Building a Function

```bash
cd function-<name>
make build
```

### Testing a Function

```bash
cd function-<name>
make test
```

### Pushing to Local Registry

```bash
cd function-<name>
make push-local
```

## 📚 Resources

- [Crossplane Function Documentation](https://docs.crossplane.io/latest/concepts/composition-functions/)
- [Writing Functions in Go](https://docs.crossplane.io/latest/guides/write-a-composition-function-in-go/)
- [Writing Functions in Python](https://docs.crossplane.io/latest/guides/write-a-composition-function-in-python/)

## 🎯 Development Workflow

1. Create a new function directory
2. Implement the function logic
3. Add tests
4. Build and test locally
5. Push to local registry (`kind-registry.local:5005`)
6. Test in a composition
7. Publish to production registry (when ready)

## 📝 Notes

- Each function is independently versioned
- Functions can be developed in Go, Python, or other supported languages
- Use the local HTTPS registry for testing before publishing
- See `../infra/README.md` for setting up the local development environment

