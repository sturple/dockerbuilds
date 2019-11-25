
DEVOP_USERNAME=${1}


echo >&2 "Who am I : $(whoami)  ${DEVOP_USERNAME}"
# getting latest vim plugin
curl -fLo /home/${DEVOP_USERNAME}/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim;
#setting up directories
mkdir -p /home/${DEVOP_USERNAME}/.config/nvim;
mkdir -p /home/${DEVOP_USERNAME}/.tmux/;

cp /tmp/init.vim /home/${DEVOP_USERNAME}/.config/nvim/
cp /tmp/tmux.conf /home/${DEVOP_USERNAME}/.tmux/
ln -s /home/${DEVOP_USERNAME}/.tmux/tmux.conf /home/${DEVOP_USERNAME}/.tmux.conf;

chmod 666 /home/${DEVOP_USERNAME}/.profile
mkdir -p /home/${DEVOP_USERNAME}/.vim/plugged
cd /home/${DEVOP_USERNAME}/.vim/plugged
