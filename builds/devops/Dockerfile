FROM ubuntu:latest
MAINTAINER Shawn Turple <shawn@turple.ca>

ENV DEVOP_USERNAME=devop
ENV TZ=America/Vancouver
ENV DEBIAN_FRONTEND=noninteractive

RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
    sudo software-properties-common \
    curl git unzip zip neovim tmux ca-certificates python3.6 libfuse2 fuse docker.io docker-compose openssh-client lxc iptables;

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone; \
     apt-get install -y vim-gtk;


ADD ./docker-entrypoint.sh ./user-setup.sh /usr/local/bin/

RUN dpkg -i /tmp/pcloud.deb; \
    chmod -R +x /usr/local/bin/; \
    useradd -m ${DEVOP_USERNAME} --uid 10072 && echo "${DEVOP_USERNAME}:password" | chpasswd && adduser ${DEVOP_USERNAME} sudo; \
    passwd -d ${DEVOP_USERNAME}; \
    chown -R ${DEVOP_USERNAME}:${DEVOP_USERNAME} /tmp && chmod -R 777 /tmp;

RUN mkdir -p /tmp/vim/plugin; \
    cd /tmp/vim/plugin; \
#   git clone https://github.com/scrooloose/nerdtree.git;\
#   git clone https://github.com/Xuyuanp/nerdtree-git-plugin.git;\
    git clone https://github.com/godlygeek/tabular.git;\
    git clone https://github.com/isobit/vim-darcula-colors.git; \
    git clone https://github.com/dsawardekar/wordpress.vim.git;

ADD ./.bash_aliases ./.config/nvim/init.vim ./.tmux/tmux.conf /tmp/
ADD ./*.deb /tmp/

USER ${DEVOP_USERNAME}
VOLUME /data

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/bin/bash"]
