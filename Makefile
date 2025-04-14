#!/bin/make
include .env

#---------------------- Make Environment ----------------------
.DEFAULT_GOAL := help
SHELL= /bin/sh
docker_bin= $(shell command -v docker 2> /dev/null)
docker_compose_bin= docker compose
COMPOSE_CONFIG=--env-file .env -p $(PROJECT_NAME) -f docker/docker-compose.$(ENVIRONMENT).yml

#---------------------- Make Commands ----------------------
help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
build: ## Build production all containers
	@echo "🚀 Copying production environments file"
	ln -s .env.example ./.env

	@echo "🚀 Starting build production containers"
	$(docker_compose_bin) --env-file .env up --build -d
dev-build: ## Build dev all containers
	@echo "🚀 Copying development environments file"
	ln -s .env.dev ./.env

	@echo "🚀 Starting build dev containers"
	$(docker_compose_bin) --env-file .env.dev up --build -d
logs: ## Logs all containers
	$(docker_compose_bin) $(COMPOSE_CONFIG) logs
restart: ## Restart all containers
	$(docker_compose_bin) $(COMPOSE_CONFIG) restart
up: ## Start all containers (in background)
	@echo "🚀 Running all containers"
	$(docker_compose_bin) $(COMPOSE_CONFIG) up -d
down: ## Stop all started containers
	@echo "🚀 Stopping all containers"
	$(docker_compose_bin) $(COMPOSE_CONFIG) down
sh-php: ## Enter to PHP container
	@echo "🚀 Enter to PHP container"
	$(docker_compose_bin) $(COMPOSE_CONFIG) exec --user=user:1000 php bash
sh-php-root: ## Enter to PHP Root container
	@echo "🚀 Enter to PHP Root container"
	$(docker_compose_bin) $(COMPOSE_CONFIG) exec --user=root:root php bash
sh-mongo: ## Enter to Mongo container
	@echo "🚀 Enter to Mongo container"
	$(docker_compose_bin) $(COMPOSE_CONFIG) exec mongodb bash
sh-rabbit: ## Enter to Rabbit container
	@echo "🚀 Enter to Rabbit container"
	$(docker_compose_bin) $(COMPOSE_CONFIG) exec --user=user:1000 rabbitmq bash
sh-mailhog: ## Enter to Mailhog container
	@echo "🚀 Enter to Mailhog container"
	$(docker_compose_bin) $(COMPOSE_CONFIG) run --user=user:1000 mail bash
