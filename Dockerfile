FROM alpine:latest
MAINTAINER Darin Egan <darinegan@gmail.com>

RUN apk add --no-cache \
    ca-certificates

RUN apk add --no-cache --virtual .build-deps\
        gcc \
        libc-dev \
        libgcc \
        linux-headers \
    && apk add --no-cache \
        py-pip \
        python \
        python-dev \
    && pip install --upgrade \
        pip \
    && pip install --no-cache-dir \
        python-openstackclient \
    && apk del .build-deps

COPY callback.sh /callback.sh
RUN chmod +x /callback.sh
ENTRYPOINT [ "/callback.sh" ]

CMD [ "openstack" ]
