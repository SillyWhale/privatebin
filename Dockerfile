FROM alpine:latest
LABEL maintainer="Vincent FRICOU <vincent@fricouv.eu>"

ENV PB_VERSION=1.1.1
ENV PB_PKG=${PB_VERSION}.tar.gz
ENV PB_URL=https://github.com/PrivateBin/PrivateBin/archive/${PB_PKG}
ENV PB_ROOT_DIR=/privatebin

RUN \
  apk update && apk upgrade && \
  apk add curl nginx supervisor ca-certificates tar && \
  apk add php7-fpm php7-gd php7-mcrypt php7-json php7-zlib php7-pdo php7-pdo_mysql && \
  rm /etc/nginx/conf.d/default.conf && rm /etc/php7/php-fpm.d/www.conf && \
  mkdir ${PB_ROOT_DIR} && cd ${PB_ROOT_DIR} && \
  curl --silent --location ${PB_URL} --output ${PB_PKG} && \
  tar xf ${PB_PKG} --strip 1 && \
  rm ${PB_PKG} && \
  apk del tar ca-certificates curl libcurl && rm -rf /var/cache/apk/*

COPY includes/nginx.conf /etc/nginx/default.conf
COPY includes/php7-fpm.conf /etc/php7/php-fpm.d/privatebin.conf
COPY includes/supervisord.conf /usr/local/etc/supervisord.conf
COPY includes/entrypoint.sh /entrypoint.sh

RUN \ 
  chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]