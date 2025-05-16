#  Description: Nginx Dockerfile

# pull the base image
FROM debian:bullseye

# install nginx and openssl
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y nginx openssl 


# create the ssl directory
RUN mkdir -p /etc/nginx/ssl

# generate the ssl certificate
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout \
    /etc/nginx/ssl/inception.key -subj "/C=MO/ST=KH/L=KH/O=42/OU=42/CN=tzi-qi.42.fr/UID=$WP_ADMIN_N"

# copy the nginx configuration file
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# Expose the port 443 
EXPOSE 443

# set entrypoint to run the shell script
ENTRYPOINT ["./nginx_init.sh"]

# define the command to run when the container starts
CMD ["nginx", "-g", "daemon off;"]
