# this builds the same images as build.sh, just with 8 jobs

set -ex

# just change these to bump the version
readonly JETPACK_VERSION="r32.4.4"
readonly OPENCV_VERSION="4.4.0"

# get gpg key
cp /etc/apt/sources.list.d/nvidia-l4t-apt-source.list .
cp /etc/apt/trusted.gpg.d/jetson-ota-public.asc .

# build the image
docker build \
    --build-arg OPENCV_BUILD_JOBS=$(nproc) \
    --build-arg JETPACK_VERSION=${JETPACK_VERSION} \
    --build-arg OPENCV_VERSION=${OPENCV_VERSION} \
    -t qomolo/qeye:jp-${JETPACK_VERSION}-cv-${OPENCV_VERSION} \
    . 2>&1 | tee build.log
