SHELL := /bin/bash

.PHONY: up down status clean help

help:
	@echo "Usage:"
	@echo "  make up      - Create Kind cluster and HTTPS registry"
	@echo "  make status  - Show status of the cluster and registry"
	@echo "  make down    - Destroy everything"

up:
	./scripts/cluster.sh up

status:
	./scripts/cluster.sh status

down:
	./scripts/cluster.sh down
