# Description: MariaDB Dockerfile

# pull base image 
FROM debian:bullseye

# update and upgrade the system 
RUN apt-get update && apt-get update -y 

# install the required packages
RUN apt-get install -y mariadb-server netcat

# Ensure socket directory exists
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

# expose the port 3306 (MariaDB default port)
EXPOSE 3306

# copy file from host to container
COPY ./tools/mdb-conf.sh /tools/mdb-conf.sh

# set permission to the file
RUN chmod +x tools/mdb-conf.sh

# define entrepoint command to run when the container starts
ENTRYPOINT ["/bin/bash", "/tools/mdb-conf.sh"]

# command used by exec in bash script
CMD ["mysqld_safe"]
