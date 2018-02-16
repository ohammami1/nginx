#!/bin/sh

cp crossover-api.conf /etc/nginx/sites-available/

ln -s /etc/nginx/sites-available/crossover-api.conf /etc/nginx/sites-enabled/crossover-api
rm /etc/nginx/sites-enabled/default
