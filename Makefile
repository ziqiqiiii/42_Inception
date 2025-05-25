HOME    = /home/tzi-qi
WP_DATA = ${HOME}/data/wordpress #define the path to the wordpress data
DB_DATA = ${HOME}/data/mariadb #define the path to the mariadb data

all: create_dir build up

create_dir:
	@mkdir -p $(WP_DATA)
	@mkdir -p $(DB_DATA)

# START THE BUILDING PROCESS
up:
	docker compose -f ./docker-compose.yml up -d

# STOP THE CONTAINERS 
down:
	docker compose -f ./docker-compose.yml down --volumes

# BUILD THE CONTAINERS
build:
	docker compose -f ./docker-compose.yml build

# STOP THE CONTAINERS
stop:
	docker compose stop

# START THE EXISTING CONTAINERS
start:
	docker compose start

# CLEAN THE CONTAINERS
clean: down
	@docker system prune -af --volumes
	@rm -rf "$(WP_DATA)" || true
	@rm -rf "$(DB_DATA)" || true

# CLEAN AND START THE CONTAINERS 
re: clean up

.PHONY: create_dir up down build stop start clean
