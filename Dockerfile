FROM alpine:edge

# This should work, but due to recent changes in log4cplus, for now it doesn't
#RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
#    apk add --no-cache kea-dhcp4=1.5.0-r2

# So instead we do this for now
RUN apk update && \
    apk add procps alpine-sdk git autoconf automake openssl openssl-dev boost-dev libtool pkgconfig && \
    cd /tmp && \
    git clone --depth 1 -b 2.0.x https://github.com/log4cplus/log4cplus.git && \
    cd log4cplus && \
    git submodule update --init --recursive && \
    autoreconf && \
    ./configure && \
    make && \
    make install && \
    cd /tmp && \
    git clone --depth 1 -b Kea-1.5.0 https://github.com/isc-projects/kea.git && \
    cd kea && \
    autoreconf --install && \
    ./configure && \
    make && \
    make install && \
    rm -rf /tmp/* && \
    apk del alpine-sdk git autoconf automake pkgconfig openssl-dev && \
    rm -rf /var/cache/apk/*

RUN mkdir /etc/kea

EXPOSE 67/udp

CMD ["/usr/local/sbin/kea-dhcp4","-c","/etc/kea/kea-dhcp4.conf"]
