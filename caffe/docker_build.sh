set -ex

# just change these to bump the version
readonly JETPACK_VERSION="r32.4.4"
readonly OPENCV_VERSION="4.4.0"

# build the image
docker build \
    -t harbor.qomolo.com/arm64/qeye:jp-${JETPACK_VERSION}-cv-${OPENCV_VERSION}-caffe \
    . 2>&1 | tee build.log