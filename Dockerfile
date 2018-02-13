#
# Nginx Dockerfile
#
# https://github.com/dockerfile/nginx
#
# Pull base image.
FROM nginx:1.12

ADD nginx.conf /etc/nginx/

# Define mountable directories.
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/var/www/html"]

# Define working directory.
WORKDIR /etc/nginx

# Define default command.
CMD ["nginx"]

# Expose ports.
EXPOSE 80
EXPOSE 443