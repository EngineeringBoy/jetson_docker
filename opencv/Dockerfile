ARG JETPACK_VERSION="r32.4.4"

FROM nvcr.io/nvidia/l4t-base:${JETPACK_VERSION}

COPY ubuntu18.04.list /etc/apt/sources.list
COPY nvidia-l4t-apt-source.list /etc/apt/sources.list.d/
COPY jetson-ota-public.asc /etc/apt/trusted.gpg.d/jetson-ota-public.asc
### build argumements ###
# change these here or with --build-arg FOO="BAR" at build time
ARG OPENCV_VERSION="4.4.0"
ARG OPENCV_DO_TEST="FALSE"
# note: 8 jobs will fail on Nano. Try 1 instead.
ARG OPENCV_BUILD_JOBS="4"
# required for apt-get -y to work properly:
ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /usr/local/src/build_opencv

COPY build_opencv.sh .

RUN /bin/bash build_opencv.sh
