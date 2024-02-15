# Build services
build:
	docker-compose build

build-no-cache:
	docker-compose build --no-cache

# Start services in the foreground
up:
	docker-compose up

# Start services in the background
up-detached:
	docker-compose up -d

# Stop services
stop:
	docker-compose stop

# Stop and remove containers, networks, volumes, and images created by 'up'
down:
	docker-compose down

# View logs
logs:
	docker-compose logs

# Prune system - removes stopped containers, unused networks, dangling images, and build cache
prune:
	docker system prune -f

# Prune system including unused containers and images
prune-all:
	docker system prune -a -f

# Prune volumes - removes unused volumes
prune-volumes:
	docker volume prune -f

# Execute a command in a running container
# Usage: make exec service=[service_name] cmd="[command]"
exec:
	docker-compose exec $(service) $(cmd)

# DEBUG Docker containers
check_status:
	@echo "\n$(YELLOW)docker ps -a $(RESET)" && docker ps -a
	@echo "\n$(YELLOW)docker volume ls $(RESET)" && docker volume ls
	@echo "\n$(YELLOW)docker images -a $(RESET)" && docker images -a
	@echo "\n$(YELLOW)docker network ls $(RESET)" && docker network ls

# DEBUG Docker logs
check_logs:
	@if [ -n "$$(docker ps -aq)" ]; then \
		echo "$(YELLOW)\n. . . showing docker logs . . . \n$(RESET)"; \
		echo "\n$(YELLOW)Postgres logs:$(RESET)"; docker-compose logs; \
	else \
		echo "\n$(BOLD)$(RED)No Docker containers found.$(RESET)\n"; \
	fi

.PHONY: build build-no-cache up up-detached down stop logs prune prune-all prune-volumes exec

# COLORS
RESET = \033[0m
WHITE = \033[37m
GREY = \033[90m
RED = \033[91m
DRED = \033[31m
GREEN = \033[92m
DGREEN = \033[32m
YELLOW = \033[93m
DYELLOW = \033[33m
BLUE = \033[94m
DBLUE = \033[34m
MAGENTA = \033[95m
DMAGENTA = \033[35m
CYAN = \033[96m
DCYAN = \033[36m

# FORMAT
BOLD = \033[1m
ITALIC = \033[3m
UNDERLINE = \033[4m
STRIKETHROUGH = \033[9m
