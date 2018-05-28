#!/bin/sh

if [ ! -f ${PB_ROOT_DIR}/cfg/conf.php ]; then
	cp ${PB_ROOT_DIR}/cfg/conf.sample.php ${PB_ROOT_DIR}/cfg/conf.php
fi

chown -R nginx:nginx /privatebin
supervisord -c /usr/local/etc/supervisord.conf &
sleep 10
tail -f /supervisord.log /var/log/nginx/privatebin_access.log /var/log/nginx/privatebin_error.log /var/log/nginx/privatebin.access.log