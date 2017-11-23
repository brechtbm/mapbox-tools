FROM alpine:3.6

MAINTAINER David Stefan <stefda@gmail.com>

# add tippecanoe dependencies
RUN apk --no-cache update && \
    apk --no-cache add bash openssl g++ make sqlite-dev zlib-dev

# install tippecanoe
ENV TIPPECANOE_VERSION 1.27.0

RUN wget https://github.com/mapbox/tippecanoe/archive/${TIPPECANOE_VERSION}.tar.gz && \
    tar xzvf ${TIPPECANOE_VERSION}.tar.gz && \
    cd /tippecanoe-${TIPPECANOE_VERSION} && \
    make && \
    make install

# install aws cli
ENV AWS_CLI_VERSION 1.11.188

RUN apk --no-cache update && \
    apk --no-cache add python py-pip py-setuptools ca-certificates groff less && \
    pip --no-cache-dir install awscli==${AWS_CLI_VERSION} && \
    rm -rf /var/cache/apk/*

# add upload dependencies
RUN apk --no-cache update && \
    apk --no-cache add curl jq

ADD upload.sh /bin/upload

WORKDIR /workdir
