FROM debian:jessie

RUN apt-get update && apt-get install -y \
    nginx

ADD nginx.conf /etc/nginx/

RUN echo "upstream php-upstream { server php:9000; }" > /etc/nginx/conf.d/upstream.conf

RUN usermod -u 1000 www-data

ADD entrypoint.sh /usr/bin/entrypoint.sh
CMD sh /usr/bin/entrypoint.sh
CMD ["nginx"]