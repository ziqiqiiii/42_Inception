WP_DATA = ${HOME}/data/wordpress #define the path to the wordpress data
DB_DATA = ${HOME}/data/mariadb #define the path to the mariadb data

# default target
all: up

# START THE BUILDING PROCESS
# create the wordpress and mariadb data directories
# start the containers in the background and leaves them running
up: build
	@mkdir -p $(WP_DATA)
	@mkdir -p $(DB_DATA)
	docker compose -f ./docker-compose.yml up -d

# STOP THE CONTAINERS 
down:
	docker compose -f ./docker-compose.yml down

# START THE CONTAINERS
start:
	docker compose -f ./docker-compose.yml start

# BUILD THE CONTAINERS
build:
	docker compose -f ./docker-compose.yml build

# CLEAN THE CONTAINERS
# stop all the running containers and remove them
# remove all images, volumes and networks
# remove the wordpress and mariadb data directories
# the (|| true) is used to ignore the error if there're no containers running to prevent the make command from stopping
clean:
	@docker stop $$(docker ps -qa) || true
	@docker rm $$(docker ps -qa) || true
	@docker rmi -f $$(docker images -qa) || true
	@docker volume rm $$(docker volume ls -q) || true 
	@docker network rm $$(docker network ls -q) || true
	@rm -rf $(WP_DATA) || true
	@rm -rf $(DB_DATA) || true

# CLEAN AND START THE CONTAINERS 
re: clean up

# PRUNE THE CONTAINERS
# execute the clean target and remove all containers, images, volumes and networks from the system.
prune: clean
	@docker system prune -a --volumes -f
	