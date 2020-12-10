ARG JETPACK_VERSION="jp-r32.4.4"

FROM harbor.qomolo.com/arm64/qeye:${JETPACK_VERSION}

COPY ubuntu18.04.list /etc/apt/sources.list
COPY nvidia-l4t-apt-source.list /etc/apt/sources.list.d/
COPY jetson-ota-public.asc /etc/apt/trusted.gpg.d/
### build argumements ###
# change these here or with --build-arg FOO="BAR" at build time
ARG OPENCV_VERSION="4.4.0"
ARG OPENCV_DO_TEST="FALSE"
# note: 8 jobs will fail on Nano. Try 1 instead.
ARG OPENCV_BUILD_JOBS="4"
# required for apt-get -y to work properly:
ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /usr/local/src/build_opencv

RUN mv /etc/apt/sources.list.d/nvidia-l4t-apt-source.list /etc/apt/
RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates
RUN mv /etc/apt/nvidia-l4t-apt-source.list /etc/apt/sources.list.d
RUN apt-get update && apt-get install -y --no-install-recommends \
        gosu \
        cuda-compiler-10-2 \
        cuda-minimal-build-10-2 \
        cuda-libraries-dev-10-2 \
        libcudnn8-dev \
        build-essential \
        cmake \
        git \
        gfortran \
        libatlas-base-dev \
        libavcodec-dev \
        libavformat-dev \
        libavresample-dev \
        libeigen3-dev \
        libgstreamer-plugins-base1.0-dev \
        libgstreamer-plugins-good1.0-dev \
        libgstreamer1.0-dev \
        libjpeg-dev \
        libjpeg8-dev \
        libjpeg-turbo8-dev \
        liblapack-dev \
        liblapacke-dev \
        libopenblas-dev \
        libpng-dev \
        libpostproc-dev \
        libswscale-dev \
        libtbb-dev \
        libtbb2 \
        libtesseract-dev \
        libtiff-dev \
        libv4l-dev \
        libx264-dev \
        pkg-config \
        python3-dev \
        python3-numpy \
        python3-pil \
        python3-matplotlib \
        v4l-utils \
        zlib1g-dev

COPY build_opencv.sh .

RUN /bin/bash build_opencv.sh
