FROM harbor.qomolo.com/arm64/qeye:jp-r32.4.4-cv-4.4.0-caffe as opencv_caffe

FROM harbor.qomolo.com/arm64/qeye:deepstream-base

ENV DEBIAN_FRONTEND=noninteractive

COPY ubuntu18.04.list /etc/apt/sources.list
COPY nvidia-l4t-apt-source.list /etc/apt/sources.list.d/
COPY jetson-ota-public.asc /etc/apt/trusted.gpg.d/

RUN mv /etc/apt/sources.list.d/nvidia-l4t-apt-source.list /etc/apt/
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates
RUN mv /etc/apt/nvidia-l4t-apt-source.list /etc/apt/sources.list.d
RUN apt-get update && apt-get install -y --no-install-recommends 

# WORKDIR /cmake
# RUN apt-get update && apt-get install -y --no-install-recommends \
#         && apt-get install build-essential libssl-dev -y
# RUN wget https://cmake.org/files/v3.18/cmake-3.18.4.tar.gz 

# RUN tar xf cmake-3.18.4.tar.gz cmake-3.18.4/ && cd cmake-3.18.4 \
#         && ./configure && make -j$(nproc) && make install && ldconfig

# RUN rm /cmake -rf

COPY --from=opencv_caffe /opt/opencv /opt/opencv
COPY --from=opencv_caffe /opt/caffe /opt/caffe
ENV CAFFE_ROOT=/opt/caffe
ENV PYCAFFE_ROOT $CAFFE_ROOT/python
ENV PYTHONPATH $PYCAFFE_ROOT:$PYTHONPATH
ENV PATH $CAFFE_ROOT/bin:$PYCAFFE_ROOT:$PATH
RUN echo "$CAFFE_ROOT/lib" >> /etc/ld.so.conf.d/caffe.conf && ldconfig
ENV OpenCV_DIR=/opt/opencv/lib/cmake
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/opencv/lib

RUN apt-get update && apt-get install -y \
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
    libyaml-cpp-dev \
    nlohmann-json-dev \
    libfmt-dev \
    libspdlog-dev \
    libtbb-dev


WORKDIR /workspace

# change the locale from POSIX to UTF-8
RUN locale-gen en_US en_US.UTF-8 && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG=en_US.UTF-8

# add the ROS deb repo to the apt sources list
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    git \
    build-essential \
    curl \
    wget \ 
    gnupg2 \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*

# RUN wget --no-check-certificate https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc && apt-key add ros.asc
COPY repo_signing.key /repo_signing.key 
RUN apt-key add /repo_signing.key
RUN sh -c 'echo "deb [arch=$(dpkg --print-architecture)] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros2-latest.list'

# install ROS packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ros-eloquent-ros-base \
    ros-eloquent-launch-xml \
    ros-eloquent-launch-yaml \
    ros-eloquent-vision-msgs \
    ros-eloquent-nav-2d-msgs \
    ros-eloquent-nav-2d-utils \
    ros-eloquent-nav2-msgs \
    ros-eloquent-nav2-costmap-2d \
    ros-eloquent-nav2-behavior-tree \
    ros-eloquent-nav2-core \
    ros-eloquent-dwb-msgs \
    ros-eloquent-behaviortree-cpp-v3 \
    ros-eloquent-example-interfaces \
    ros-eloquent-control-msgs \
    ros-eloquent-realtime-tools \
    ros-eloquent-image-transport \
    ros-eloquent-camera-info-manager \
    libpython3-dev \
    python3-colcon-common-extensions \
    python3-rosdep \
    && rm -rf /var/lib/apt/lists/*

# install gstreamer
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libgstreamermm-1.0-dev \
    libgstreamer1.0-dev \
    && rm -rf /var/lib/apt/lists/*

# init/update rosdep
# RUN apt-get update && \
#     cd ${ROS_ROOT} && \
#     rosdep init && \
#     rosdep update && \
#     rm -rf /var/lib/apt/lists/*

# compile yaml-cpp-0.6, which some ROS packages may use (but is not in the 18.04 apt repo)
# RUN git clone --branch yaml-cpp-0.6.0 https://github.com/jbeder/yaml-cpp yaml-cpp-0.6 && \
#     cd yaml-cpp-0.6 && \
#     mkdir build && \
#     cd build && \
#     cmake -DBUILD_SHARED_LIBS=ON .. && \
#     make -j$(nproc) && \
#     cp libyaml-cpp.so.0.6.0 /usr/lib/aarch64-linux-gnu/ && \
#     ln -s /usr/lib/aarch64-linux-gnu/libyaml-cpp.so.0.6.0 /usr/lib/aarch64-linux-gnu/libyaml-cpp.so.0.6

COPY build_yaml.sh /build_yaml.sh
RUN sh /build_yaml.sh
RUN rm /workspace -rf && rm /repo_signing.key /build_yaml.sh

RUN apt-get update && \
    apt-get install -y ros-eloquent-image-transport-plugins && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /
