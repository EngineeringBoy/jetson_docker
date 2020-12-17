FROM harbor.qomolo.com/arm64/qeye:latest

RUN apt-get update && apt-get install -y \
    ros-eloquent-image-transport \
    ros-eloquent-image-transport-plugins \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /

RUN rm -rf data code dst

WORKDIR /