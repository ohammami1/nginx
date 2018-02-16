#
# Nginx Dockerfile
#
# https://github.com/dockerfile/nginx
#
# Pull base image.
FROM nginx:1.12

ADD nginx.conf /etc/nginx/

# Define default command.
CMD ["nginx"]