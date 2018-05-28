#!/bin/sh

PB_DISCUTION=${PB_DISCUTION:-'true'}
PB_OPEN_DISCUTION=${PB_OPEN_DISCUTION:-'false'}
PB_PASSWORD=${PB_PASSWORD:-'true'}
PB_FILEUPLOAD=${PB_FILEUPLOAD:-'true'}
PB_BURNAFTERREAD=${PB_BURNAFTERREAD:-'false'}
PB_SIZELIMIT=${PB_SIZELIMIT:-'2097152'}
PB_TEMPLATE=${PB_TEMPLATE:-'bootstrap'}
PB_QRCODE=${PB_QRCODE:-'true'}
PB_ZEROBINCOMPAT=${PB_ZEROBINCOMPAT:-'false'}
PB_DB=${PB_DB:-'none'}

sed -i 's/discussion = true/discussion = ${PB_DISCUTION}/g' ${PB_ROOT_DIR}/cfg/conf.php
sed -i 's/opendiscussion = false/opendiscussion = ${PB_OPEN_DISCUTION}/g' ${PB_ROOT_DIR}/cfg/conf.php
sed -i 's/password = true/password = ${PB_PASSWORD}/g' ${PB_ROOT_DIR}/cfg/conf.php
sed -i 's/fileupload = true/fileupload = ${PB_FILEUPLOAD}/g' ${PB_ROOT_DIR}/cfg/conf.php
sed -i 's/burnafterreadingselected = false/burnafterreadingselected = ${PB_BURNAFTERREAD}/g' ${PB_ROOT_DIR}/cfg/conf.php
sed -i 's/sizelimit = 2097152/sizelimit = ${PB_SIZELIMIT}/g' ${PB_ROOT_DIR}/cfg/conf.php
sed -i 's/template = "bootstrap"/template = "${PB_TEMPLATE}"/g' ${PB_ROOT_DIR}/cfg/conf.php
sed -i 's/qrcode = true/qrcode = ${PB_QRCODE}/g' ${PB_ROOT_DIR}/cfg/conf.php
sed -i 's/zerobincompatibility = false/zerobincompatibility = ${PB_ZEROBINCOMPAT}/g' ${PB_ROOT_DIR}/cfg/conf.php

case ${PB_DB} in
    sqlite)
        echo '[model]' >> ${PB_ROOT_DIR}/cfg/conf.php
        echo 'class = Database' >> ${PB_ROOT_DIR}/cfg/conf.php
        echo '[model_options]' >> ${PB_ROOT_DIR}/cfg/conf.php
        echo 'dsn = "sqlite:" PATH "/privatebin-data/db.sq3"' >> ${PB_ROOT_DIR}/cfg/conf.php
        echo 'opt[12] = true	; PDO::ATTR_PERSISTENT  ' >> ${PB_ROOT_DIR}/cfg/conf.php
    ;;
    mysql)
        echo '[model]' >> ${PB_ROOT_DIR}/cfg/conf.php
        echo 'class = Database' >> ${PB_ROOT_DIR}/cfg/conf.php
        echo '[model_options]' >> ${PB_ROOT_DIR}/cfg/conf.php
        echo "dsn = \"mysql:host=${PB_MYSQL_DB_HOST};dbname=${PB_MYSQL_DB_NAME};charset=UTF8\"" >> ${PB_ROOT_DIR}/cfg/conf.php
        echo 'tbl = "privatebin_"' >> ${PB_ROOT_DIR}/cfg/conf.php
        echo "usr = \"${PB_MYSQL_DB_USERNAME}\"" >> ${PB_ROOT_DIR}/cfg/conf.php
        echo "pwd = \"${PB_MYSQL_DB_PASSWORD}\"" >> ${PB_ROOT_DIR}/cfg/conf.php
        echo "opt[12] = true	  ; PDO::ATTR_PERSISTENT"
    ;;
    *)
        echo "[model]"  >> ${PB_ROOT_DIR}/cfg/conf.php
        echo "class = Filesystem"  >> ${PB_ROOT_DIR}/cfg/conf.php
        echo "[model_options]"  >> ${PB_ROOT_DIR}/cfg/conf.php
        echo 'dir = PATH "/privatebin-data"'  >> ${PB_ROOT_DIR}/cfg/conf.php
    ;;
esac

chown -R nginx:nginx /privatebin /privatebin-data
supervisord -c /usr/local/etc/supervisord.conf &
sleep 5
tail -f /supervisord.log /var/log/nginx/privatebin_access.log /var/log/nginx/privatebin_error.log /var/log/nginx/privatebin.access.log