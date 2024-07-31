# Use your favorite image
FROM ubuntu
ARG S6_OVERLAY_VERSION=3.2.0.0

RUN apt-get update && apt-get install -y  xz-utils passwd gosu


ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-x86_64.tar.xz


COPY cont-init.d/ /etc/cont-init.d/
COPY cont-finish.d /etc/cont-finish.d/
RUN chmod +x /etc/cont-init.d/* && chmod +x /etc/cont-finish.d/*

ENTRYPOINT ["/init"]

CMD ["s6-svscan", "/etc/services.d"]