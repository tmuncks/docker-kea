FROM ubuntu:focal

# Add isc-kea repository
ADD https://dl.cloudsmith.io/public/isc/kea-1-8/cfg/gpg/gpg.4DD5AE28ADA7268E.key /etc/apt/trusted.gpg.d/kea.asc
RUN chmod 0644 /etc/apt/trusted.gpg.d/kea.asc \
  && apt-get update \
  && apt-get install -y ca-certificates \
  && echo 'deb [arch=amd64] https://dl.cloudsmith.io/public/isc/kea-1-8/deb/ubuntu focal main' >> /etc/apt/sources.list

# Install isc-kea-dhcp4-server
RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y isc-kea-dhcp4-server=1.8.2-isc0001520201206093433 \
  #&& mkdir /var/run/kea \
  && rm -rf /var/lib/apt/lists/*

EXPOSE 67/udp

CMD ["/usr/sbin/kea-dhcp4","-c","/etc/kea/kea-dhcp4.conf"]
