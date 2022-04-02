# refs: https://hub.docker.com/_/alpine
ARG ALPINE_VERSION=3.15.3

FROM alpine:${ALPINE_VERSION} as pgbouncer

# refs: https://www.pgbouncer.org/downloads/
ARG PGBOUNCER_VERSION=1.17.0

RUN apk add -U --no-cache \
  c-ares-dev \
  g++ \
  gcc \
  gzip \
  libevent-dev \
  make \
  openssl-dev \
  pkgconfig \
  tar \
  && mkdir /src
WORKDIR /src

# Download pgbouncer sources
ADD https://www.pgbouncer.org/downloads/files/${PGBOUNCER_VERSION}/pgbouncer-${PGBOUNCER_VERSION}.tar.gz /src/pgbouncer-${PGBOUNCER_VERSION}.tar.gz
ADD https://www.pgbouncer.org/downloads/files/${PGBOUNCER_VERSION}/pgbouncer-${PGBOUNCER_VERSION}.tar.gz.sha256 /src/pgbouncer-${PGBOUNCER_VERSION}.tar.gz.sha256
RUN sha256sum -c pgbouncer-${PGBOUNCER_VERSION}.tar.gz.sha256 && tar zxf pgbouncer-${PGBOUNCER_VERSION}.tar.gz && mv pgbouncer-${PGBOUNCER_VERSION} pgbouncer
WORKDIR /src/pgbouncer

# Compile pgbouncer
RUN ./configure --prefix=/usr/local --with-cares
RUN make -j$(nproc)
RUN make install

FROM alpine:${ALPINE_VERSION} as main

RUN apk add -U --no-cache \
  c-ares \
  ca-certificates \
  libevent \
  libintl \
  openssl \
  && apk add --no-cache --virtual .gettext gettext \
  && cp /usr/bin/envsubst /usr/local/bin/envsubst \
  && apk del .gettext \
  && addgroup -S pgbouncer \
  && adduser -S -D -H -G pgbouncer pgbouncer

COPY --from=pgbouncer /usr/local/bin/pgbouncer /usr/local/bin/pgbouncer
COPY rootfs/usr /usr
COPY --chown=pgbouncer:pgbouncer rootfs/etc /etc

USER pgbouncer
WORKDIR /etc/pgbouncer
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
CMD [ "/usr/local/bin/pgbouncer", "/etc/pgbouncer/pgbouncer.ini" ]
