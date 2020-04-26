FROM codercom/code-server:latest

USER root

RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
    #nodejs npm python3.6 python-pip python3-pip git cmake
    python3.6 python-pip python3-pip cmake make nodejs curl git gcc clang npm pkg-config;

RUN npm install npm@latest -g && mkdir /tools && chown coder:coder /tools;
WORKDIR /tools

USER 1000

RUN git clone --recursive https://github.com/WebAssembly/wabt && \
    cd wabt && mkdir build && cd build && cmake .. && cmake --build .;

RUN echo "PATH=/tools/wabt/bin:/home/coder/.cargo/bin:/home/coder/.wasmer/bin:${PATH}" >> /home/coder/.bashrc

RUN mkdir /tools/rust/ && cd /tools/rust/ && \
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > rust-setup.sh  && chmod +x rust-setup.sh ;
RUN /bin/sh /tools/rust/rust-setup.sh --default-host x86_64-unknown-linux-gnu --default-toolchain stable --profile default -y  ;

RUN cd /tools/rust/ && curl https://get.wasmer.io -sSfL > wasmer.sh && chmod +x wasmer.sh;
RUN /bin/sh /tools/rust/wasmer.sh
RUN $(/home/coder/.cargo/bin/cargo install wasm-pack cargo-generate)
RUN export USER=coder

#RUN curl -sS https://getcomposer.org/installer | php -- \
#    --filename=composer \
#    --install-dir=/usr/local/bin; 
#FROM sturple/webassembly 
#USER 1000

ENTRYPOINT ["dumb-init", "code-server", "--host", "0.0.0.0", "--auth", "none", "--disable-telemetry" ]
