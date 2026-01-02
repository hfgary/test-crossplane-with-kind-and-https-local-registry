SHELL := /bin/bash

.PHONY: help up down status

help:
	@echo "Crossplane Monorepo - Available Commands:"
	@echo ""
	@echo "Infrastructure (Dev Environment):"
	@echo "  make up      - Create Kind cluster and HTTPS registry"
	@echo "  make down    - Destroy cluster and registry"
	@echo "  make status  - Show status of cluster and registry"
	@echo ""
	@echo "For more commands, see:"
	@echo "  make -C infra help"

# Infrastructure commands (delegate to infra/)
up:
	./infra/scripts/cluster.sh up

down:
	./infra/scripts/cluster.sh down

status:
	./infra/scripts/cluster.sh status
