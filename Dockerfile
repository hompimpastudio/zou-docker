# ----------------------
# zou Docker Image
# ----------------------
# syntax=docker/dockerfile:1.4
FROM python:3.10-alpine AS builder
LABEL maintainer="Hompimpa admin@hompimpastudio.co.id"
RUN echo "Build zou"

# Generate locale C.UTF-8 for postgres and general locale data
ENV LANG=C.UTF-8

WORKDIR /src
COPY zou .
RUN apk update && \
    apk add --no-cache \
        bash \
        build-base \
        bzip2 \
        ffmpeg \
        jpeg-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        linux-headers \
        python3-dev \
        libpq-dev
RUN sed -i "s/\s\{4,\}gevent==21.8.0/    gevent==20.9.0/g" setup.cfg && \
    python3 setup.py install

COPY ./scripts/entrypoint.sh /

FROM builder as build

# ----------------------
# kitsu environment vars
# ----------------------
ENV WORKERS=3
ENV TIMEOUT=300
ENV DB_HOST=localhost
ENV DB_PORT=5432
ENV DB_USERNAME=zou
ENV DB_PASSWORD=zou
ENV DB_DATABASE=zou
ENV KV_HOST=localhost
ENV KV_PORT=6379
ENV SECRET_KEY=secret_key
ENV FS_BACKEND=s3
ENV FS_S3_REGION=eu-central-1
ENV FS_S3_ENDPOINT=http://127.0.0.1:9000
ENV FS_S3_ACCESS_KEY=fs_f3_access_key
ENV FS_S3_SECRET_KEY=fs_f3_secret_key
ENV MAIL_SERVER=smtp.example.com
ENV MAIL_PORT=465
ENV MAIL_USERNAME=youremail@example.com
ENV MAIL_PASSWORD=mail_password
ENV MAIL_USE_SSL=True
ENV MAIL_DEFAULT_SENDER=youremail@example.com
ENV DOMAIN_NAME=localhost
ENV DOMAIN_PROTOCOL=http
ENV ENABLE_JOB_QUEUE=True
ENV PREVIEW_FOLDER=/opt/zou/previews
ENV USER_LIMIT=100

USER zou
ENTRYPOINT ["/entrypoint.sh"]
