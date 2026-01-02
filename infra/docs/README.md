# Documentation

This folder contains additional documentation and reference materials for the project.

## 📁 Contents

### `setup-notes.md`
Original manual setup notes and configuration steps. These steps are now mostly automated by the scripts in the `scripts/` folder, but this document is kept for:
- Reference and understanding of what the automation does
- Troubleshooting when automation fails
- Manual configuration if needed

**Topics covered:**
- Installing mkcert
- Generating certificates manually
- Configuring /etc/hosts
- Manual registry trust configuration
- Testing and cleanup commands

### `images.md`
Reference document for image operations and registry interactions.

**Topics covered:**
- Querying the registry catalog
- Listing image tags
- Manual image pull/tag/push operations
- Helm installation commands

## 🎯 Purpose

These documents serve as:

1. **Reference material** - For understanding the underlying setup
2. **Troubleshooting guide** - When automated scripts need debugging
3. **Learning resource** - To understand how the components work together
4. **Historical record** - Showing the evolution from manual to automated setup

## 📚 Related Documentation

- **Main README** - [`../README.md`](../README.md) - Quick start and overview
- **Kubernetes Configs** - [`../k8s-manifests/README.md`](../k8s-manifests/README.md) - Kind configuration details
- **Working Memory** - [`../working-memory/`](../working-memory/) - Development notes and troubleshooting

## 🔄 Automation vs. Manual

Most operations documented here are now automated:

| Manual Step (in docs) | Automated By |
|----------------------|--------------|
| Certificate generation | `scripts/cluster.sh up` |
| Registry trust config | `scripts/cluster.sh up` |
| Image operations | `scripts/crossplane-images.sh`, `scripts/provider-images.sh` |
| Crossplane installation | `scripts/install-crossplane.sh` |
| Provider installation | `scripts/install-providers.sh` |

**When to use manual steps:**
- Debugging automation issues
- Understanding what the scripts do
- Customizing the setup beyond what scripts provide
- Learning the underlying technology

## ✏️ Contributing

When adding new documentation:

1. Keep it focused on reference and manual operations
2. Link to automated alternatives when available
3. Update this README to include the new document
4. Use clear examples and code blocks

---

**Note**: For day-to-day usage, refer to the main README and use the automated scripts. Use these docs when you need to understand or troubleshoot the underlying setup.

