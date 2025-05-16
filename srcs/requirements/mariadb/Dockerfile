# Description: MariaDB Dockerfile

# pull base image 
FROM debian:bullseye

# update and upgrade the system 
RUN apt-get update && apt-get update -y 

# install the required packages
RUN apt-get install -y mariadb-server netcat

# expose the port 3306 (MariaDB default port)
EXPOSE 3306

# copy file from host to container
COPY ./mdb-conf.sh /mdb-conf.sh

# set permission to the file
RUN chmod +x /mdb-conf.sh

# define entrepoint command to run when the container starts
ENTRYPOINT ["/bin/bash", "./mdb-conf.sh"]

# command used by exec in bash script
CMD ["mysqld_safe"]
