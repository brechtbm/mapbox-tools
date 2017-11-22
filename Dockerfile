FROM alpine:3.6

MAINTAINER David Stefan <stefda@gmail.com>

# add required dependencies
RUN apk add --update bash openssl g++ make sqlite-dev zlib-dev

# install tippecanoe
RUN wget https://github.com/mapbox/tippecanoe/archive/1.27.0.tar.gz && \
    tar xzvf 1.27.0.tar.gz && \
    cd tippecanoe-1.27.0

RUN make && make install

# remove dependencies that are no longer needed
RUN apk del --purge bash openssl make

WORKDIR /workdir
