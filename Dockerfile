FROM eafxx/alpine-python
LABEL MAINTAINER="eafxx"

ENV \
  APP_DIR=traktarr \
  TRAKTARR_CONFIG=/config/config.json \
  TRAKTARR_LOGFILE=/config/traktarr.log \
  TZ=

# Install packages
RUN \
    apk add --no-cache curl py3-setuptools tzdata && \
    if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi && \
    pip3 install --no-cache-dir --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi

# add local files
COPY root/ /

# Change directory
WORKDIR /${APP_DIR}

# Config volume
VOLUME /config