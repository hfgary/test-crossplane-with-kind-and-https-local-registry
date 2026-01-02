SHELL := /bin/bash

.PHONY: help up down status verify fix push-crossplane push-providers install-crossplane install-providers list-images

help:
	@echo "Infrastructure Commands:"
	@echo ""
	@echo "Cluster Management:"
	@echo "  make up              - Create Kind cluster and HTTPS registry"
	@echo "  make down            - Destroy cluster and registry"
	@echo "  make status          - Show status of cluster and registry"
	@echo "  make verify          - Verify registry connectivity"
	@echo "  make fix             - Fix registry network issues"
	@echo ""
	@echo "Image Management:"
	@echo "  make push-crossplane - Push Crossplane image to local registry"
	@echo "  make push-providers  - Push provider images to local registry"
	@echo "  make push-all        - Push all images to local registry"
	@echo "  make list-images     - List all images in registry"
	@echo ""
	@echo "Crossplane Management:"
	@echo "  make install-crossplane - Install Crossplane with CA certificate"
	@echo "  make install-providers  - Install Crossplane providers"
	@echo "  make install-all        - Install Crossplane and providers"
	@echo ""
	@echo "Complete Setup:"
	@echo "  make setup           - Complete setup (up + push + install)"

# Cluster management
up:
	./scripts/cluster.sh up

down:
	./scripts/cluster.sh down

status:
	./scripts/cluster.sh status

verify:
	./scripts/cluster.sh verify

fix:
	./scripts/cluster.sh fix

# Image management
push-crossplane:
	./scripts/crossplane-images.sh

push-providers:
	./scripts/provider-images.sh

push-all: push-crossplane push-providers

list-images:
	./scripts/list-registry-images.sh

# Crossplane management
install-crossplane:
	./scripts/install-crossplane.sh

install-providers:
	./scripts/install-providers.sh

install-all: install-crossplane install-providers

# Complete setup
setup: up push-all install-all
	@echo ""
	@echo "✅ Complete setup finished!"
	@echo ""
	@echo "Verify with:"
	@echo "  kubectl get deployments -n crossplane-system"
	@echo "  kubectl get providers"

