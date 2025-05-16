#  Description: Nginx Dockerfile

# pull the base image
FROM debian:bullseye

# install nginx and openssl
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y nginx openssl 

# Expose the port 443 
EXPOSE 443

# copy the nginx configuration file
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# copy the bash script and set permission
COPY ./tools/nginx_init.sh /tools/nginx_init.sh
RUN chmod +x /tools/nginx_init.sh

# create the ssl directory
RUN mkdir -p /etc/nginx/ssl

# set entrypoint to run the shell script
ENTRYPOINT ["./nginx_init.sh"]

# define the command to run when the container starts
CMD ["nginx", "-g", "daemon off;"]

# FROM debian:bullseye-slim

# # install nginx and openssl
# RUN apt-get update
# RUN apt-get install nginx vim -y
# RUN apt-get install openssl -y

# # copy over the init.sh bash script and set execute permissions
# COPY ./tools/init.sh ./init.sh
# RUN chmod 755 init.sh

# COPY ./config/nginx.conf /etc/nginx/nginx.conf

# # make the private directory for ssl
# RUN mkdir -p /etc/ssl/private
# RUN chmod 700 /etc/ssl/private

# EXPOSE 443

# # set the cmd to run as init.sh
# ENTRYPOINT ["./init.sh"]