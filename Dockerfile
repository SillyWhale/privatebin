FROM alpine:latest
LABEL maintainer="Vincent FRICOU <vincent@fricouv.eu>"

ENV PB_VERSION=1.1.1
ENV PB_PKG=${PB_VERSION}.tar.gz
ENV PB_URL=https://github.com/PrivateBin/PrivateBin/archive/${PB_PKG}
ENV PB_ROOT_DIR=/privatebin

RUN \
  apk update && apk upgrade && \
  apk install curl nginx supervisor ca-certificates tar && \
  apk install php7-fpm php7-gd php7-mcrypt php7-json php7-zlib php7-pdo php7-pdo_mysql

RUN \
  mkdir ${PB_ROOT_DIR} && cd ${PB_ROOT_DIR} && \
  curl --silent --location ${PB_URL} --output ${PB_PKG} && \
  tar xf ${PB_PKG} --strip 1 && \
  rm ${PB_PKG} && \
  cp ${PB_ROOT_DIR}/cfg/conf.sample.php ${PB_ROOT_DIR}

RUN \ 
  apk del tar ca-certificates curl libcurl && rm -rf /var/cache/apk/*