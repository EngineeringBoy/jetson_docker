set -ex

if [ ! -f "/usr/lib/aarch64-linux-gnu/libyaml-cpp.so.0.6" ];then
    git clone --branch yaml-cpp-0.6.0 https://github.com/jbeder/yaml-cpp yaml-cpp-0.6 && \
        cd yaml-cpp-0.6 && \
        mkdir build && \
        cd build && \
        cmake -DBUILD_SHARED_LIBS=ON .. && \
        make -j$(nproc) && \
        cp libyaml-cpp.so.0.6.0 /usr/lib/aarch64-linux-gnu/ && \
        ln -s /usr/lib/aarch64-linux-gnu/libyaml-cpp.so.0.6.0 /usr/lib/aarch64-linux-gnu/libyaml-cpp.so.0.6
else
    echo "yaml has been compiled successfully!"
fi