FROM harbor.qomolo.com/arm64/qeye:jp-r32.4.4-cv-4.4.0

RUN apt-get update && apt-get install -y --no-install-recommends \ 
    build-essential \ 
    openjdk-8-jdk \
    python \
    zip \
    unzip \
    protobuf-compiler \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /tf2

RUN wget --no-check-certificate https://mirrors.huaweicloud.com/bazel/3.2.0/bazel-3.2.0-dist.zip
RUN unzip bazel-3.2.0-dist.zip -d bazel-3.2.0-dist

RUN chmod -R ug+rwx /tf2/bazel-3.2.0-dist

RUN cd bazel-3.2.0-dist && ./compile.sh
RUN cp /tf2/bazel-3.2.0-dist/output/bazel /usr/local/bin
RUN rm /tf -rf


