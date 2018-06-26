# Supported tags and respective `Dockerfile` links

- [`latest` (*latest/Dockerfile*)](https://github.com/SillyWhale/privatebin/blob/master/Dockerfile)

# Quick reference

- **Where to file issues**:  
  [https://github.com/SillyWhale/privatebin/issues](https://github.com/SillyWhale/privatebin/issues)

- **Maintained by**:  
  [SillyWhale](https://github.com/SillyWhale/privatebin)

- **Source of this description**:  
  [docs repo's directory](https://github.com/SillyWhale/_documentation)

- **Supported Docker versions**:  
  [the latest release](https://github.com/docker/docker-ce/releases/latest)

# What is privatebin ?

[Privatebin](https://privatebin.info/) description.  

# How to use this image

## Usage

Use like you would any other base image:

```dockerfile
FROM alpine:latest
LABEL maintainer="SillyWhale <contact@sillywhale.wtf>"

ENV PB_VERSION=1.1.1 \
    PB_URL=https://github.com/PrivateBin/PrivateBin/archive/${PB_PKG} \
    PB_ROOT_DIR=/privatebin
ENV PB_PKG=${PB_VERSION}.tar.gz

RUN \
  apk update && apk upgrade && \
  apk add curl nginx supervisor ca-certificates tar && \
  apk add php7-fpm php7-gd php7-mcrypt php7-json php7-zlib php7-pdo php7-pdo_mysql && \
  rm /etc/nginx/conf.d/default.conf && rm /etc/php7/php-fpm.d/www.conf && \
  mkdir ${PB_ROOT_DIR} && cd ${PB_ROOT_DIR} && \
  curl --silent --location ${PB_URL} --output ${PB_PKG} && \
  tar xf ${PB_PKG} --strip 1 && \
  rm ${PB_PKG} && \
  mkdir /run/nginx && \
  mkdir /privatebin-data && \
  echo "daemon off;" >> /etc/nginx/nginx.conf && \
  apk del tar ca-certificates curl libcurl && rm -rf /var/cache/apk/*

COPY includes/nginx.conf /etc/nginx/conf.d/default.conf
COPY includes/php7-fpm.conf /etc/php7/php-fpm.d/privatebin.conf
COPY includes/supervisord.conf /usr/local/etc/supervisord.conf
COPY includes/entrypoint.sh /entrypoint.sh
COPY includes/privatebin.conf.php ${PB_ROOT_DIR}/cfg/conf.php

RUN \ 
  chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
```

This yields us a virtual image size of about 4MB image.

## Documentation

This image is well documented. [Check out the documentation at Viewdocs](http://docs.sillywhale.com/privatebin/).

# License

View [license information](https://github.com/PrivateBin/PrivateBin/blob/master/LICENSE.md) for the software contained in this image.

As with all Docker images, these likely also contain other software which may be under other licenses (such as Bash, etc from the base distribution, along with any direct or indirect dependencies of the primary software being contained).

As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.