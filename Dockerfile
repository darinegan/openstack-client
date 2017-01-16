FROM alpine:latest
MAINTAINER Darin Egan <darinegan@gmail.com>

RUN apk --no-cache add \
    ca-certificates

RUN apk add --no-cache --virtual .build-deps\
        gcc \
        libc-dev \
        libgcc \
        linux-headers \
    && apk --no-cache add \
        py-pip \
        python \
        python-dev \
    && pip install --upgrade \
        pip \
    && pip install --no-cache-dir \
        python-openstackclient \
    && apk del .build-deps

COPY start.sh /start.sh
RUN chmod +x /start.sh
ENTRYPOINT [ "/start.sh" ]

CMD [ "openstack" ]
