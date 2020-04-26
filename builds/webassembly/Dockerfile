FROM ubuntu:latest

USER root

RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
    python3.6 python-pip python3-pip cmake make nodejs curl git gcc clang npm pkg-config;

RUN npm install npm@latest -g
WORKDIR /tools

RUN git clone --recursive https://github.com/WebAssembly/wabt && \
    cd wabt && mkdir build && cd build && cmake .. && cmake --build .;

RUN echo "PATH=/tools/wabt/bin:/root/.cargo/bin:${PATH}" >> /root/.bashrc

RUN mkdir /tools/rust/ && cd /tools/rust/ && \
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > rust-setup.sh  && \
/bin/sh rust-setup.sh --default-host x86_64-unknown-linux-gnu --default-toolchain stable --profile default -y  ;

RUN $(/root/.cargo/bin/cargo install wasm-pack)



