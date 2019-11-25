#!/bin/bash
set -e
PASSWORD=${DEVOP_PASSWORD-password}
echo >&2 "${DEVOP_USERNAME} ${PASSWORD}"
if [ "$DEVOP_USERNAME" != "devop" ]; then
    echo >&2 "Creating new user. ${DEVOP_USERNAME}"
    sudo useradd \
    --create-home \
    --groups docker,devop \
    --shell /bin/bash \
    --uid ${DEVOP_USERID-1000} \
    ${DEVOP_USERNAME}
    sudo passwd -d ${DEVOP_USERNAME};
fi

sudo mkdir -p /data /config
sudo chown ${DEVOP_USERNAME}:${DEVOP_USERNAME} /data /config

# setup nvim plugins.
sudo su ${DEVOP_USERNAME} ./usr/local/bin/user-setup.sh "${DEVOP_USERNAME}"
## get plugins.
echo >&2 "Getting Plugins for Neovim..."
sudo mv /tmp/vim/plugin/* /home/${DEVOP_USERNAME}/.vim/plugged
sudo mv /tmp/.bash_aliases /home/${DEVOP_USERNAME}
sudo chown -R ${DEVOP_USERNAME}:${DEVOP_USERNAME} /home/${DEVOP_USERNAME}/

#sudo rm -rf /tmp/*
#sudo -u ${DEVOP_USERNAME} nvim -u /home/${DEVOP_USERNAME}/.config/nvim/init.vim :PlugInstall
sudo su - ${DEVOP_USERNAME}

exec "$@"
