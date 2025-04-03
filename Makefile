DOCKER_COMPOSE=docker-compose
DOCKER_COMPOSE_FILE=./srcs/docker-compose.yml

.PHONY: kill build down clean restart

build:
	@echo "Building containers..."
	@mkdir -p ./srcs/ihaffout/data/mysql
	@mkdir -p ./srcs/ihaffout/data/wordpress
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) up --build -d
	@echo "Containers built and running."

kill:
	@echo "Stopping containers..."
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) kill
	@echo "Containers stopped."

down:
	@echo "Removing containers..."
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down
	@echo "Containers removed."

clean:
	@echo "Cleaning up..."
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down --volumes --remove-orphans
	@echo "Cleaned up."

fclean:
	@echo "Cleaning up..."
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down --volumes --remove-orphans
	@rm -rf ./srcs/ihaffout/data/mysql/*
	@rm -rf ./srcs/ihaffout/data/wordpress/*
	@echo "Cleaned up."

restart:
	clean build