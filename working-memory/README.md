# Working Memory

This folder contains documentation and notes created during the development and troubleshooting of this project. These files serve as a reference for understanding the setup process, fixes applied, and security considerations.

## 📁 Contents

### `REGISTRY_FIX.md`
Detailed documentation of the registry connectivity and TLS certificate issues that were encountered and how they were resolved:
- Network connectivity problems between pods and registry
- TLS certificate trust issues in Crossplane pods
- Step-by-step fixes applied to `cluster.sh` and `install-crossplane.sh`

### `SETUP_COMPLETE.md`
Comprehensive summary of the completed setup:
- Current status of all components (registry, Crossplane, providers)
- Verification steps and commands
- Quick start guide for new setups
- Troubleshooting tips

### `SECURITY.md`
Security guidelines and best practices:
- Explanation of sensitive files (TLS certificates, private keys)
- Why certain files should never be committed
- Security best practices for local development
- What to do if secrets are accidentally committed
- Regular security check commands

### `GIT_COMMIT_GUIDE.md`
Step-by-step guide for making your first commit:
- Pre-commit verification checklist
- Suggested commit messages
- Files that are safe to commit vs. files that are protected
- Troubleshooting common git issues

## 🎯 Purpose

These documents were created to:

1. **Document the journey** - Track problems encountered and solutions applied
2. **Provide context** - Help future developers understand why certain decisions were made
3. **Security awareness** - Ensure sensitive files are properly protected
4. **Onboarding** - Help new team members get up to speed quickly

## 📚 How to Use

- **New to the project?** Start with `SETUP_COMPLETE.md` for an overview
- **Having issues?** Check `REGISTRY_FIX.md` for troubleshooting
- **Ready to commit?** Read `GIT_COMMIT_GUIDE.md` and `SECURITY.md`
- **Understanding security?** Review `SECURITY.md` for best practices

## 🗂️ Organization

This folder is intentionally separate from the main project documentation to:
- Keep the root directory clean
- Distinguish between "working notes" and "official documentation"
- Allow these files to be optionally excluded from commits if desired
- Serve as a knowledge base for the development process

## ✏️ Contributing

Feel free to add more documentation here as you:
- Encounter and solve new issues
- Discover better approaches
- Learn new insights about the setup
- Document additional troubleshooting steps

---

**Note**: These files are safe to commit and can be helpful for other developers working on similar setups.

