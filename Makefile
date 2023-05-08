#!/usr/bin/make

#----------- Make Environment ----------------------
.DEFAULT_GOAL := help
SHELL= /bin/sh
docker_bin= $(shell command -v docker 2> /dev/null)
docker_compose_bin= $(shell command -v docker-compose 2> /dev/null)

help: ## Show this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "  \033[92m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
build: ## Build all containers
	$(docker_compose_bin) up --build -d
up: ## Start all containers (in background)
	$(docker_compose_bin) up -d
down: ## Stop all started containers
	$(docker_compose_bin) down
sh-php: ## Enter to PHP container
	$(docker_compose_bin) exec --user=user:1000 php bash
sh-php-root: ## Enter to PHP Root container
	$(docker_compose_bin) exec php bash
sh-mongo: ## Enter to Mongo container
	$(docker_compose_bin) exec mongodb bash
sh-rabbit: ## Enter to Rabbit container
	$(docker_compose_bin) exec --user=1000:1000 rabbitmq bash
sh-node: ## Enter to Node container
	$(docker_compose_bin) run --user=1000:1000 node bash
sh-mailhog: ## Enter to Mailhog container
	$(docker_compose_bin) run --user=1000:1000 mail bash
