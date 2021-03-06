#!/usr/bin/env bash

ENV_NAMES=$(export | cut -d' ' -f 3- | cut -d'=' -f 1)

DIST_FILE=/etc/nginx/dist/project-site.conf.dist
CONF_FILE=/etc/nginx/sites-enabled/project-site.conf
LOG_PATH=/var/log/nginx
NGINX_LOG_PREFIX=${PROJECT_NAME}

if ! [ -f ${DIST_FILE} ]; then
	echo "File not found, exiting..."
	exit 1
fi

mkdir -p /etc/nginx/sites-enabled

cp ${DIST_FILE} ${CONF_FILE}

for i in ${ENV_NAMES}; do 
	#echo "ENV: s/__${i}__/${!i}/g"
	if [ -z ${!i} ]; then continue; fi
	if echo ${!i} | grep '/' >/dev/null 2>&1 ; then continue; fi

	sed -i ${CONF_FILE} -e "s/__${i}__/${!i}/g"
done

if cat ${CONF_FILE} | grep '__' >/dev/null 2>&1 ; then
	echo "Warning: They're still unbound variables in ${CONF_FILE}, you probabely didn't define those in your environment section"
fi

touch /var/log/nginx/${NGINX_LOG_PREFIX}_access.log
touch /var/log/nginx/${NGINX_LOG_PREFIX}_error.log
touch /var/log/nginx/error.log

chmod a+rw /var/log/nginx/${NGINX_LOG_PREFIX}*.log
chmod a+rw /var/log/nginx/error.log
chmod a+rw /var/log/nginx

exec "$@"
