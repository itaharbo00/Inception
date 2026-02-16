# Inception Makefile

NAME = inception
DOCKER_COMPOSE = docker compose -f ./srcs/docker-compose.yml
DATA_PATH = /home/itaharbo/data

# Default target
all: create_dirs up

# Create data directories on host
create_dirs:
	@mkdir -p $(DATA_PATH)/wordpress
	@mkdir -p $(DATA_PATH)/mariadb

build:
	@$(DOCKER_COMPOSE) up -d --build

# Build images and start containers
up: create_dirs
	@$(DOCKER_COMPOSE) up -d

# Stop containers
down:
	@$(DOCKER_COMPOSE) down

# Stop and remove containers, networks
clean: down
	@docker system prune -f

# Remove everything including volumes and data
fclean: down
	@$(DOCKER_COMPOSE) down --volumes --rmi all
	@docker system prune -af
	@sudo rm -rf $(DATA_PATH)/wordpress/*
	@sudo rm -rf $(DATA_PATH)/mariadb/*

# Rebuild everything
re: fclean all

# Show running containers
ps:
	@$(DOCKER_COMPOSE) ps

# Show logs
logs:
	@$(DOCKER_COMPOSE) logs -f

.PHONY: all create_dirs  up down clean fclean re ps logs
