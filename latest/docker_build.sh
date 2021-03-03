set -ex

# just change these to bump the version
readonly VERSION="full"

# build the image
docker build \
    -t harbor.qomolo.com/arm64/qeye:${VERSION} \
    . 2>&1 | tee build.log