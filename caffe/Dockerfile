ARG BASE_IMAGE=harbor.qomolo.com/arm64/qeye:jp-r32.4.4-cv-4.4.0
FROM ${BASE_IMAGE}

WORKDIR /cmake
RUN apt-get update && apt-get install -y --no-install-recommends \
        && apt-get remove --purge cmake -y && hash -r \
        && apt-get install build-essential libssl-dev -y
RUN wget https://cmake.org/files/v3.18/cmake-3.18.4.tar.gz 

RUN tar xf cmake-3.18.4.tar.gz cmake-3.18.4/ && cd cmake-3.18.4 \
        && ./configure && make -j$(nproc) && make install && ldconfig

RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        cmake \
        git \
        wget \
        libatlas-base-dev \
        libboost-all-dev \
        libgflags-dev \
        libgoogle-glog-dev \
        libhdf5-serial-dev \
        libleveldb-dev \
        liblmdb-dev \
        libopencv-dev \
        libprotobuf-dev \
        libsnappy-dev \
        protobuf-compiler \
        bash-completion \
        dirmngr \
        gnupg2 \
        lsb-release \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y --no-install-recommends \
        python3-dev \
        python3-numpy \
        python3-pip \
        python3-setuptools \
        python3-scipy \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /caffe

ENV CLONE_TAG="ws_qeye"

RUN git clone -b ${CLONE_TAG} --depth 1 https://gitlab.qomolo.com/mirrors/timosaemann/caffe-enet.git .
    # pip3 install --upgrade pip --trusted-host mirrors.aliyun.com -i http://mirrors.aliyun.com/pypi/simple/ && \
    # pip3 install -r python/requirements.txt --trusted-host mirrors.aliyun.com -i http://mirrors.aliyun.com/pypi/simple/

RUN mkdir build && cd build && \
    export OpenCV_DIR=/opt/opencv/lib/cmake/opencv4 && \ 
    cmake -D USE_NCCL=1 \
          -D CMAKE_INSTALL_PREFIX=/opt/caffe .. && \
    make -j"$(nproc)" && \
    make install


ENV CAFFE_ROOT=/opt/caffe
ENV PYCAFFE_ROOT $CAFFE_ROOT/python
ENV PYTHONPATH $PYCAFFE_ROOT:$PYTHONPATH
ENV PATH $CAFFE_ROOT/bin:$PYCAFFE_ROOT:$PATH
RUN echo "$CAFFE_ROOT/lib" >> /etc/ld.so.conf.d/caffe.conf && ldconfig

WORKDIR /