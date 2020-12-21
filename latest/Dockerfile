FROM harbor.qomolo.com/arm64/qeye:jp-r32.4.4-cv-4.4.0-caffe-ros-eloquent

COPY packages/libtensorflow.tar.gz /tmp

#RUN rm -rf /usr/local/lib/libtensorflow* /usr/local/include/tensorflow
RUN mkdir /opt/tensorflow-2.4 && tar zxvf /tmp/libtensorflow.tar.gz -C /opt/tensorflow-2.4 
ENV LIBRARY_PATH $LIBRARY_PATH:/opt/tensorflow-2.4/lib
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/opt/tensorflow-2.4/lib

RUN rm -rf /tmp/*

WORKDIR /