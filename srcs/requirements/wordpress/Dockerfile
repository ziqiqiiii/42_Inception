# Description: Wordpress Dockerfile 

# pull base image 
FROM debian:bullseye

# update and upgrade the system 
# install the required packages 
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y curl php php7.4-fpm php-mysql mariadb-client

# copy the wordpress configuration script to the root directory on the container
COPY ./tools/wp_conf.sh /

# give executable permission of the script
RUN chmod +x wp_conf.sh

# define the entrypoint command to run when the container starts
ENTRYPOINT ["./tools//wp_conf.sh"]
