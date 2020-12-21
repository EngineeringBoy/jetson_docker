set -ex

# just change these to bump the version
readonly VERSION="jp-r32.4.4-cv-4.4.0-caffe-ros-eloquent"

# get gpg key
cp /etc/apt/sources.list.d/nvidia-l4t-apt-source.list .
cp /etc/apt/trusted.gpg.d/jetson-ota-public.asc .

# build the image
docker build \
    -t harbor.qomolo.com/arm64/qeye:${VERSION} \
    . 2>&1 | tee build.log