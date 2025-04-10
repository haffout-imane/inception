DOCKER_COMPOSE=docker-compose
DOCKER_COMPOSE_FILE=./srcs/docker-compose.yml

.PHONY: kill build down clean restart

build:
	@echo "Building containers..."
	@mkdir -p ~/data/database ~/data/files
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) up --build -d
	@echo "Containers built and running."


info:
	@echo "\033[1;36m--- Docker Disk Usage ---\033[0m"
	@docker system df
	@echo

	@echo "\033[1;36m--- Running Containers ---\033[0m"
	@docker ps
	@echo

	@echo "\033[1;36m--- Docker Images ---\033[0m"
	@docker images
	@echo

	@echo "\033[1;36m--- Docker Volumes ---\033[0m"
	@docker volume ls
	@echo

	@echo "\033[1;36m--- Docker Networks ---\033[0m"
	@docker network ls
	@echo

stop:
	@echo "Stopping containers..."
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) stop
	@echo "Containers stopped."

start:
	@echo "starting containers..."
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) start
	@echo "Containers started."

down:
	@echo "Removing containers..."
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down
	@echo "Containers removed."

clean:
	@echo "Full cleanup in progress..."
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down --volumes --remove-orphans
	@sudo rm -rf ~/data/database ~/data/files
	@docker stop $(shell docker ps -qa) 2>/dev/null || true
	@docker rm $(shell docker ps -qa) 2>/dev/null || true
	@docker rmi -f $(shell docker images -qa) 2>/dev/null || true
	@docker volume rm $(shell docker volume ls -q) 2>/dev/null || true
	@docker network rm $(shell docker network ls -q) 2>/dev/null || true
	@docker system prune
	@echo "Docker environment fully cleaned."

restart: clean build