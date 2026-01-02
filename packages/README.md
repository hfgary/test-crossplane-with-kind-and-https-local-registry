# Shared Packages

This directory contains shared and reusable code used across functions, providers, and configurations.

## 📁 Structure

```
packages/
├── README.md                    # This file
├── common-compositions/         # Reusable composition patterns
│   └── README.md
├── common-functions/            # Shared function utilities
│   └── README.md
└── testing-utils/               # Shared testing utilities
    └── README.md
```

## 🎯 Purpose

This directory is for code and configurations that are:
- Used by multiple functions, providers, or configurations
- Generic and reusable
- Not specific to a single project

## 📦 Package Types

### Common Compositions
Reusable composition patterns that can be imported or referenced by multiple configurations.

### Common Functions
Shared utility code for composition functions (e.g., common transformations, validation logic).

### Testing Utils
Shared testing utilities, fixtures, and helpers used across the monorepo.

## 🚀 Usage

### Importing Shared Code

```go
// In a function
import "github.com/your-org/crossplane-monorepo/packages/common-functions/transforms"
```

### Referencing Shared Compositions

```yaml
# In a configuration
apiVersion: apiextensions.crossplane.io/v1
kind: Composition
metadata:
  name: my-composition
spec:
  # Reference shared composition patterns
  ...
```

## 📝 Best Practices

- Keep packages focused and well-documented
- Version shared packages carefully (changes affect multiple consumers)
- Add comprehensive tests for shared code
- Document all public APIs
- Consider backward compatibility when making changes

## 📝 Notes

- Shared packages should be stable and well-tested
- Breaking changes require coordination across all consumers
- Consider semantic versioning for shared packages
- Document dependencies clearly

