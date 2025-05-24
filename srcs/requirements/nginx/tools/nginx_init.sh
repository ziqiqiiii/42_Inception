#!/bin/bash

#--------------Gnerating SSL Certificate--------------#
echo "Generating SSL Certificate ... "
openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout \
    /etc/nginx/ssl/inception.key -subj "/C=MO/ST=KH/L=KH/O=42/OU=42/CN=$DOMAIN_NAME/UID=$WP_ADMIN_N"
echo "Done"

#--------------Start Nginx--------------#
nginx -g "daemon off;"
