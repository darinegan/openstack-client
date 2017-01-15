FROM alpine:latest
MAINTAINER Darin Egan <darinegan@gmail.com>

RUN apk --no-cache add \
    ca-certificates

RUN buildDeps=' \
        gcc \
        libc-dev \
        libgcc \
        linux-headers \
    ' \
    && apk --no-cache add \
        $buildDeps \
        py-pip \
        python \
        python-dev \
    && pip install --upgrade \
        pip \
    && pip install \
        python-openstackclient \
    && apk del $buildDeps

COPY start.sh /start.sh
RUN chmod +x /start.sh
ENTRYPOINT [ "/start.sh" ]

CMD [ "openstack" ]
