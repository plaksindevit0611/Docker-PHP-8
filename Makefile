#!/usr/bin/make

#---------------------- Make Environment ----------------------
.DEFAULT_GOAL := help
SHELL= /bin/sh
docker_bin= $(shell command -v docker 2> /dev/null)
docker_compose_bin= docker compose

#---------------------- Make Commands ----------------------

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
build: ## Build production all containers
	@echo "🚀 Copying development config files"
	ln -s .env.example ./.env

	@echo "🚀 Starting build production containers"
	$(docker_compose_bin) --env-file .env up --build -d
dev-build: ## Build dev all containers
	@echo "🚀 Copying development config files"
	ln -s .env.dev ./.env

	@echo "🚀 Starting build dev containers"
	$(docker_compose_bin) --env-file .env.dev up --build -d
up: ## Start all containers (in background)
	@echo "🚀 Running all containers"
	$(docker_compose_bin) up -d
down: ## Stop all started containers
	@echo "🚀 Stopping all containers"
	$(docker_compose_bin) down
sh-php: ## Enter to PHP container
	@echo "🚀 Enter to PHP container"
	$(docker_compose_bin) exec --user=user:1000 php bash
sh-php-root: ## Enter to PHP Root container
	@echo "🚀 Enter to PHP Root container"
	$(docker_compose_bin) exec php bash
sh-mongo: ## Enter to Mongo container
	@echo "🚀 Enter to Mongo container"
	$(docker_compose_bin) exec mongodb bash
sh-rabbit: ## Enter to Rabbit container
	@echo "🚀 Enter to Rabbit container"
	$(docker_compose_bin) exec --user=1000:1000 rabbitmq bash
sh-node: ## Enter to Node container
	@echo "🚀 Enter to Node container"
	$(docker_compose_bin) run --user=1000:1000 node bash
sh-mailhog: ## Enter to Mailhog container
	@echo "🚀 Enter to Mailhog container"
	$(docker_compose_bin) run --user=1000:1000 mail bash
