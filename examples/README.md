# Examples

This directory contains end-to-end examples demonstrating how to use the functions, providers, and configurations in this monorepo.

## 📁 Structure

```
examples/
├── README.md                    # This file
├── basic-setup/                 # Basic example
│   ├── README.md
│   └── *.yaml
└── advanced-platform/           # Advanced example
    ├── README.md
    └── *.yaml
```

## 🎯 Purpose

Examples demonstrate:
- How to use functions, providers, and configurations together
- Real-world use cases
- Best practices
- Complete working setups

## 📚 Example Categories

### Basic Setup
Simple examples for getting started:
- Single resource deployments
- Basic compositions
- Simple function usage

### Advanced Platform
Complex examples showing:
- Multi-resource platforms
- Advanced composition patterns
- Function chaining
- Provider integration

## 🚀 Using Examples

### Prerequisites

1. Set up local development environment:
   ```bash
   cd infra
   make setup
   ```

2. Install required providers and functions

### Running an Example

```bash
# Navigate to an example
cd examples/basic-setup

# Follow the README in that directory
cat README.md

# Apply the example
kubectl apply -f .
```

## 📝 Creating New Examples

When creating a new example:

1. Create a new directory with a descriptive name
2. Add a README.md explaining:
   - What the example demonstrates
   - Prerequisites
   - Step-by-step instructions
   - Expected outcomes
3. Include all necessary YAML files
4. Test the example thoroughly
5. Document any cleanup steps

## 📝 Notes

- Examples should be self-contained and runnable
- Include clear documentation
- Test examples regularly to ensure they work
- Update examples when APIs change
- Consider adding screenshots or diagrams for complex examples

