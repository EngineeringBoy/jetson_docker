FROM harbor.qomolo.com/arm64/qeye:latest as tensorflow
FROM harbor.qomolo.com/arm64/qeye:jp-r32.4.4-cv-4.4.0-caffe-ros-dashing

# COPY packages/libtensorflow.tar.gz /tmp

#RUN rm -rf /usr/local/lib/libtensorflow* /usr/local/include/tensorflow
# RUN mkdir /opt/tensorflow-2.4 && tar zxvf /tmp/libtensorflow.tar.gz -C /opt/tensorflow-2.4 
COPY --from=tensorflow /opt/tensorflow-2.4 /opt/tensorflow-2.4
ENV LIBRARY_PATH $LIBRARY_PATH:/opt/tensorflow-2.4/lib
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/opt/tensorflow-2.4/lib

# RUN rm -rf /tmp/*

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ros-dashing-image-transport \
    ros-dashing-image-transport-plugins \
    ros-dashing-camera-info-manager \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /