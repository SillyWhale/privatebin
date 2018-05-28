#!/bin/sh

if [ ! -f ${PB_ROOT_DIR}/cfg/conf.php ]; then
	cp ${PB_ROOT_DIR}/cfg/conf.sample.php ${PB_ROOT_DIR}/cfg/conf.php
fi

chown -R nginx:nginx /privatebin
supervisord -c /usr/local/etc/supervisord.conf