# Security Guidelines

## 🔒 Sensitive Files

This project uses TLS certificates for the local HTTPS registry. These files are **automatically generated** by `mkcert` and should **NEVER** be committed to version control.

### Files That Are Ignored (`.gitignore`)

The following sensitive files are automatically ignored:

1. **`kind-registry-ca.pem`** - CA certificate (locally generated)
2. **`kind-registry.local-key.pem`** - 🔴 **PRIVATE KEY** (most sensitive)
3. **`kind-registry.local.pem`** - TLS certificate

### Why These Files Are Sensitive

- **Private keys** (`*-key.pem`) can be used to impersonate your registry
- **Certificates** are machine-specific and should be regenerated on each developer's machine
- Committing these files provides no value since they're self-signed and local-only

## 🛡️ Security Best Practices

### For New Developers

When setting up this project:

1. **Generate your own certificates** using `mkcert`:
   ```bash
   # Install mkcert
   brew install mkcert
   
   # Install the CA
   JAVA_HOME="" mkcert -install
   
   # The cluster.sh script will generate certificates automatically
   ./cluster.sh up
   ```

2. **Never share your private keys** - Each developer should generate their own

3. **Verify `.gitignore` is working**:
   ```bash
   git status --ignored | grep .pem
   # Should show all .pem files as ignored
   ```

### What's Safe to Commit

✅ **Safe to commit:**
- All shell scripts (`*.sh`)
- Configuration files (`*.yaml`, `Makefile`, `Tiltfile`)
- Documentation (`*.md`)
- `.gitignore` file

❌ **Never commit:**
- Certificate files (`*.pem`, `*.crt`, `*.key`)
- Kubernetes secrets (`*secret*.yaml`)
- Environment files with credentials (`.env`)
- Any file containing passwords, API keys, or tokens

## 🔍 Verification

### Check for Accidentally Committed Secrets

Before pushing to a remote repository:

```bash
# Check what will be committed
git status

# Verify .pem files are ignored
git status --ignored | grep .pem

# Check for any secrets in staged files
git diff --cached | grep -i "password\|secret\|key\|token"
```

### Audit Your Repository

If you've already committed sensitive files:

```bash
# Check git history for sensitive files
git log --all --full-history -- "*.pem"

# If found, you need to remove them from history
# Use git-filter-repo or BFG Repo-Cleaner
```

## 🚨 What to Do If You Accidentally Commit Secrets

1. **Don't panic** - If you haven't pushed yet:
   ```bash
   # Remove the file from staging
   git reset HEAD <file>
   
   # Amend the commit
   git commit --amend
   ```

2. **If you've already pushed**:
   - Rotate/regenerate the compromised credentials immediately
   - Use `git-filter-repo` to remove from history
   - Force push (if allowed) or contact repository admin
   - For public repos, consider the secrets permanently compromised

3. **For this project specifically**:
   - Regenerate certificates: `./cluster.sh down && ./cluster.sh up`
   - The certificates are self-signed and local-only, so exposure is low risk
   - Still, remove them from git history as a best practice

## 📋 `.gitignore` Coverage

The `.gitignore` file in this project covers:

- ✅ TLS certificates and private keys (`*.pem`, `*.key`, `*.crt`)
- ✅ Kubernetes secrets (`*secret*.yaml`)
- ✅ Environment files (`.env`, `*.env`)
- ✅ IDE files (`.vscode/`, `.idea/`)
- ✅ OS files (`.DS_Store`, `Thumbs.db`)
- ✅ Temporary files (`*.tmp`, `*.log`)
- ✅ Build artifacts and dependencies

## 🔐 Registry Security

### Local Development Only

This setup is designed for **local development only**:

- Registry runs on `localhost` (`kind-registry.local:5005`)
- Not exposed to the internet
- Self-signed certificates are appropriate for this use case
- No authentication required (local-only access)

### Production Considerations

If adapting this for production:

- Use proper CA-signed certificates
- Implement authentication (basic auth, OAuth, etc.)
- Use network policies to restrict access
- Enable audit logging
- Regular security updates
- Vulnerability scanning of images

## 📞 Questions?

If you're unsure whether something should be committed:

1. Check if it's in `.gitignore`
2. Ask: "Would this be useful to other developers?"
3. Ask: "Does this contain any secrets or machine-specific data?"
4. When in doubt, don't commit it

## 🔄 Regular Security Checks

Periodically run:

```bash
# Check for ignored files that might have been accidentally added
git ls-files -i --exclude-standard

# Audit for potential secrets in committed files
git grep -i "password\|secret\|api[_-]key\|token" -- '*.sh' '*.yaml'
```

---

**Remember**: Security is everyone's responsibility. When in doubt, ask!

