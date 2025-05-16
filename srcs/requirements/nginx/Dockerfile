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
