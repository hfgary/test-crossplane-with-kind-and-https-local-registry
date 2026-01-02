# Crossplane Monorepo Structure Plan

## Overview

This document outlines the recommended structure for transforming this repository into a Crossplane development monorepo that supports developing functions, providers, and configurations.

## Proposed Directory Structure

```
crossplane-monorepo/
├── .gitignore
├── Makefile                    # Root-level build orchestration
├── README.md                   # Monorepo overview
├── Tiltfile                    # Root Tilt config (can include sub-Tiltfiles)
│
├── infra/                      # Infrastructure & dev environment (current setup)
│   ├── README.md
│   ├── Makefile                # Infra-specific commands
│   ├── scripts/
│   │   ├── cluster.sh
│   │   ├── install-crossplane.sh
│   │   ├── install-providers.sh
│   │   └── ...
│   ├── k8s-manifests/
│   │   └── kind-config.yaml
│   └── docs/
│       ├── setup-notes.md
│       └── images.md
│
├── functions/                  # Crossplane Composition Functions
│   ├── README.md
│   ├── function-<name-1>/      # Individual function
│   │   ├── Dockerfile
│   │   ├── go.mod
│   │   ├── go.sum
│   │   ├── main.go
│   │   ├── fn.go
│   │   ├── package/
│   │   │   └── crossplane.yaml
│   │   ├── examples/
│   │   │   └── *.yaml
│   │   └── README.md
│   ├── function-<name-2>/
│   └── ...
│
├── providers/                  # Custom Crossplane Providers
│   ├── README.md
│   ├── provider-<name-1>/      # Individual provider
│   │   ├── Dockerfile
│   │   ├── go.mod
│   │   ├── apis/
│   │   ├── internal/
│   │   │   └── controller/
│   │   ├── package/
│   │   │   └── crossplane.yaml
│   │   ├── examples/
│   │   └── README.md
│   ├── provider-<name-2>/
│   └── ...
│
├── configurations/             # Crossplane Configuration Packages
│   ├── README.md
│   ├── platform-<name>/        # Platform configuration
│   │   ├── crossplane.yaml
│   │   ├── compositions/
│   │   │   ├── *.yaml
│   │   ├── definitions/        # XRDs (CompositeResourceDefinitions)
│   │   │   └── *.yaml
│   │   ├── functions/          # Function references
│   │   │   └── *.yaml
│   │   ├── examples/
│   │   │   └── *.yaml
│   │   └── README.md
│   ├── config-<name>/
│   └── ...
│
├── packages/                   # Shared/reusable packages
│   ├── common-compositions/    # Reusable compositions
│   ├── common-functions/       # Shared function utilities
│   └── testing-utils/          # Shared testing utilities
│
├── examples/                   # End-to-end examples
│   ├── basic-setup/
│   ├── advanced-platform/
│   └── README.md
│
├── tools/                      # Development tools & utilities
│   ├── scripts/
│   │   ├── build-all.sh
│   │   ├── test-all.sh
│   │   ├── push-packages.sh
│   │   └── validate.sh
│   ├── templates/              # Project templates
│   │   ├── function-template/
│   │   ├── configuration-template/
│   │   └── provider-template/
│   └── ci/
│       └── github-actions/
│
└── docs/                       # Monorepo-wide documentation
    ├── README.md
    ├── development-guide.md
    ├── architecture.md
    ├── contributing.md
    └── working-memory/         # Current working-memory
        ├── REGISTRY_FIX.md
        ├── SECURITY.md
        ├── MONOREPO_STRUCTURE.md  # This file
        └── ...
```

## Key Design Principles

### 1. Separation of Concerns
- **`infra/`** - Dev environment setup (isolated from Crossplane artifacts)
- **`functions/`** - Composition functions (Go, Python, etc.)
- **`providers/`** - Custom providers
- **`configurations/`** - Configuration packages (compositions + XRDs)
- **`packages/`** - Shared/reusable code

### 2. Self-Contained Artifacts
Each function, provider, or configuration should be:
- Independently buildable
- Independently testable
- Independently publishable
- Have its own README.md and examples

### 3. Standardized Structure

#### Function Structure
```
functions/function-my-logic/
├── Dockerfile              # Container image
├── go.mod / requirements.txt
├── main.go / main.py       # Entry point
├── fn.go / fn.py           # Function logic
├── package/
│   └── crossplane.yaml     # Package metadata
├── examples/
│   └── composition.yaml    # Usage examples
├── tests/
└── README.md
```

#### Configuration Structure
```
configurations/platform-aws/
├── crossplane.yaml         # Package metadata
├── compositions/
│   ├── database.yaml
│   ├── network.yaml
│   └── cluster.yaml
├── definitions/            # XRDs
│   ├── xdatabase.yaml
│   └── xnetwork.yaml
├── functions/              # Function references
│   └── function-refs.yaml
├── examples/
│   └── claim.yaml
└── README.md
```

## Migration Strategy

### Phase 1: Reorganize Infrastructure
```bash
# 1. Create infra/ directory
mkdir -p infra

# 2. Move current setup files
mv scripts/ infra/
mv k8s-manifests/ infra/
mv docs/ infra/docs/

# 3. Keep at root
# - Makefile (update to orchestrate)
# - README.md (update to describe monorepo)
# - Tiltfile (update to include sub-projects)
# - .gitignore (already good)
# - working-memory/ (move to docs/working-memory later)
```

### Phase 2: Create Project Directories
```bash
# Create main directories
mkdir -p functions
mkdir -p providers
mkdir -p configurations
mkdir -p packages
mkdir -p examples
mkdir -p tools/{scripts,ci,templates}
mkdir -p docs

# Add README files
touch functions/README.md
touch providers/README.md
touch configurations/README.md
touch packages/README.md
touch examples/README.md
touch tools/README.md
```

### Phase 3: Set Up Templates
Create templates for new projects in `tools/templates/`:
- `function-template/` - Boilerplate for new functions
- `configuration-template/` - Boilerplate for new configurations
- `provider-template/` - Boilerplate for new providers

## Root Makefile Structure

The root Makefile should orchestrate common tasks:

```makefile
.PHONY: help
help:
	@echo "Crossplane Monorepo Commands:"
	@echo "  make infra-up          - Start dev environment"
	@echo "  make infra-down        - Stop dev environment"
	@echo "  make build-functions   - Build all functions"
	@echo "  make build-configs     - Build all configurations"
	@echo "  make build-all         - Build everything"
	@echo "  make push-all          - Push all to local registry"
	@echo "  make test-all          - Run all tests"

# Infrastructure commands
.PHONY: infra-up
infra-up:
	$(MAKE) -C infra up

.PHONY: infra-down
infra-down:
	$(MAKE) -C infra down

# Build all functions
.PHONY: build-functions
build-functions:
	@for dir in functions/*/; do \
		if [ -f "$$dir/Makefile" ]; then \
			$(MAKE) -C $$dir build; \
		fi \
	done

# Build all configurations
.PHONY: build-configs
build-configs:
	@for dir in configurations/*/; do \
		if [ -f "$$dir/crossplane.yaml" ]; then \
			crossplane build configuration -f $$dir; \
		fi \
	done

# Build everything
.PHONY: build-all
build-all: build-functions build-configs

# Push all to local registry
.PHONY: push-all
push-all: build-all
	./tools/scripts/push-packages.sh

# Run all tests
.PHONY: test-all
test-all:
	./tools/scripts/test-all.sh
```

## Tiltfile Integration

Root Tiltfile can include sub-Tiltfiles for hot-reload development:

```python
# Root Tiltfile
default_registry('kind-registry.local:5005')

# Include function Tiltfiles
include('./functions/function-my-logic/Tiltfile')
include('./functions/function-another/Tiltfile')

# Include configuration Tiltfiles
include('./configurations/platform-aws/Tiltfile')
```

## Local Development Workflow

### Starting Development
```bash
# 1. Start dev environment
make infra-up

# 2. Develop a function
cd functions/function-my-logic
tilt up  # or make dev

# 3. Test locally
make test
make build
make push-local  # Push to kind-registry.local:5005

# 4. Install in cluster
kubectl apply -f package/
```

### Adding a New Function
```bash
# 1. Create from template
cp -r tools/templates/function-template functions/function-transform-labels
cd functions/function-transform-labels

# 2. Update metadata
# Edit package/crossplane.yaml

# 3. Implement logic
# Edit fn.go or fn.py

# 4. Add examples
# Create examples/*.yaml

# 5. Test
make test

# 6. Build & push
make build
make push-local
```

## Benefits

✅ **Clear Separation**: Dev environment vs. actual Crossplane artifacts
✅ **Scalable**: Easy to add new functions/providers/configs
✅ **Independent Development**: Each artifact can be worked on independently
✅ **Consistent Structure**: Developers know where to find things
✅ **CI/CD Friendly**: Easy to build/test/publish specific artifacts
✅ **Tilt Integration**: Can watch specific directories for hot-reload
✅ **Monorepo Benefits**: Shared tooling, consistent versioning, atomic changes

## Versioning Strategy

**Recommendation**: Start with independent versioning for flexibility
- Each function has its own version in `package/crossplane.yaml`
- Each configuration has its own version
- Each provider has its own version
- Can move to monorepo versioning later if needed

## CI/CD Considerations

This structure supports:
- **Path-based triggers**: Only build what changed
- **Matrix builds**: Build all functions in parallel
- **Dependency management**: Configurations depend on functions
- **Selective publishing**: Publish only changed artifacts

## Next Steps

1. **Phase 1**: Reorganize current infrastructure into `infra/`
2. **Phase 2**: Create directory structure for functions/providers/configurations
3. **Phase 3**: Create templates and tooling
4. **Phase 4**: Update root Makefile and Tiltfile
5. **Phase 5**: Create first function/configuration as example
6. **Phase 6**: Document development workflow

## References

- [Crossplane Function Development](https://docs.crossplane.io/latest/guides/write-a-composition-function-in-python/)
- [Crossplane Configuration Packages](https://docs.crossplane.io/latest/concepts/packages/)
- [Provider Development](https://docs.crossplane.io/latest/concepts/providers/)


