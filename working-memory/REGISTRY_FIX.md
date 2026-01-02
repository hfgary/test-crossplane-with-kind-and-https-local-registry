# Registry Network Fix

## Problem

Crossplane providers running inside pods couldn't access the local registry at `kind-registry.local:5005`, resulting in errors like:

```
Warning  UnpackPackage  cannot unpack package: failed to fetch package digest from remote: 
Get "https://kind-registry.local:5005/v2/": dial tcp 127.0.0.1:5005: connect: connection refused
```

## Root Cause

The registry container was not connected to the kind Docker network. When pods tried to access `kind-registry.local:5005`, they couldn't reach it because:

1. The registry was only on the default bridge network
2. Pods inside the cluster need the registry to be on the same Docker network as the kind nodes
3. The `/etc/hosts` entry pointed to an IP that wasn't accessible from inside pods

## Solution

The `cluster.sh` script has been updated to automatically:

1. **Connect the registry to the kind network** after starting it
2. **Use the kind network IP** for the registry in `/etc/hosts` entries
3. **Provide a `fix` command** to repair existing setups

## For New Clusters

Simply run:

```bash
./cluster.sh up
```

The registry will automatically be connected to the kind network.

## For Existing Clusters

If you already have a cluster and registry running, use the new `fix` command:

```bash
./cluster.sh fix
```

This will:
- Connect the registry to the kind network
- Update `/etc/hosts` in all kind nodes with the correct IP
- Make the registry accessible from inside pods

## Verify the Fix

After applying the fix, verify connectivity:

```bash
./cluster.sh verify
```

This will test:
1. ✅ Node can access registry (containerd)
2. ✅ Pods can access registry (application level)
3. ✅ Registry network information

## Reinstall Crossplane with CA Certificate Support

After fixing the network, you need to reinstall Crossplane with CA certificate mounting:

```bash
# The install-crossplane.sh script now automatically:
# 1. Creates a ConfigMap with the CA certificate
# 2. Mounts it into the Crossplane pod at /etc/ssl/certs/cert.pem

./scripts/install-crossplane.sh
```

If Crossplane is already installed, the script will ask if you want to upgrade.

## Install Providers

After Crossplane is running with CA certificate support:

```bash
./scripts/install-providers.sh
```

## Updated Commands

The `cluster.sh` script now supports:

```bash
./cluster.sh up       # Create cluster and registry (with network fix)
./cluster.sh down     # Destroy cluster and registry
./cluster.sh status   # Check status
./cluster.sh verify   # Test registry connectivity
./cluster.sh fix      # Fix registry network connection
```

## Technical Details

### What Changed

**Before:**
```bash
# Registry was only on default bridge network
docker run -d --name kind-registry.local ...
REG_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' kind-registry.local)
```

**After:**
```bash
# Registry is connected to kind network
docker run -d --name kind-registry.local ...
docker network connect kind kind-registry.local
REG_IP=$(docker inspect -f '{{.NetworkSettings.Networks.kind.IPAddress}}' kind-registry.local)
```

### Why This Works

- Kind creates a Docker network called `kind`
- All kind nodes are on this network
- By connecting the registry to the same network, pods can reach it
- The registry gets an IP on the kind network (e.g., `172.18.0.5`)
- This IP is accessible from inside pods, unlike `127.0.0.1`

## Troubleshooting

If providers still can't access the registry:

1. **Check registry is on kind network:**
   ```bash
   docker inspect kind-registry.local | grep -A 10 Networks
   ```

2. **Check registry IP:**
   ```bash
   docker inspect -f '{{.NetworkSettings.Networks.kind.IPAddress}}' kind-registry.local
   ```

3. **Check /etc/hosts in nodes:**
   ```bash
   docker exec kind-cluster-control-plane cat /etc/hosts | grep kind-registry
   ```

4. **Test from inside a pod:**
   ```bash
   kubectl run test --image=curlimages/curl --rm -i --restart=Never -- \
     curl -k https://kind-registry.local:5005/v2/
   ```

