#!/bin/bash

function command_exists() {
  if hash $1 2>/dev/null; then
    echo "${1} found. Continuing."
  else
    echo "Command ${1} not found. Exiting."
    exit 1;
  fi
}

function deploy_configuration() {
  echo "Checking whether Git is installed."
  command_exists git
  echo "Fetching the configuration files from GitHub"
  git clone https://github.com/Quintasan/conf.git ${HOME}/conf
  cd ${HOME}/conf

  echo "Fetching submodules"
  git submodule init
  git submodule update

  echo "Symlinking ${HOME}/conf/zshrc to ${HOME}/.zshrc"
  ln -fs ${HOME}/conf/zshrc ${HOME}/.zshrc

  echo "Symlinking ${HOME}/conf/vimconf/.vimrc to ${HOME}/.vimrc"
  ln -fs ${HOME}/conf/vimconf/.vimrc ${HOME}/.vimrc
  echo "Symlinking ${HOME}/conf/vimrc.plugins to ${HOME}/.vimrc.plugins"
  ln -fs ${HOME}/conf/vimrc.plugins ${HOME}/.vimrc.plugins
  echo "Symlinking ${HOME}/conf/vimrc.last to ${HOME}/.vimrc.last"
  ln -fs ${HOME}/conf/vimrc.last ${HOME}/.vimrc.last
  echo "Please start vim to fetch plugins"

  echo "Configuring NeoVim..."
  mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
  curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  ln -fs ${HOME}/conf/init.vim ${HOME}/.config/nvim/init.vim
  echo "Run nvim +PlugInstall +qall before starting NeoVim"

  echo "Symlinking ${HOME}/conf/gitconfig to ${HOME}/.gitconfig"
  ln -fs ${HOME}/conf/gitconfig ${HOME}/.gitconfig
  echo "Symlinking ${HOME}/conf/gitignore_global to ${HOME}/.gitignore_global"
  ln -fs ${HOME}/conf/gitignore_global ${HOME}/.gitignore_global
  echo "Symlinking ${HOME}/conf/gemrc to ${HOME}/.gemrc"
  ln -fs ${HOME}/conf/gemrc ${HOME}/.gemrc
  echo "Symlinking ${HOME}/conf/pryrc to ${HOME}/.pryrc"
  ln -fs ${HOME}/conf/pryrc ${HOME}/.pryrc
  echo "Symlinking ${HOME}/conf/ssh/config to ${HOME}/.ssh/config"
  mkdir -p ${HOME}/.ssh
  mkdir -p ${HOME}/.ssh/multiplex
  ln -fs ${HOME}/conf/ssh/config ${HOME}/.ssh/config
}

echo "Would you to like to deploy the configuration files to ${HOME} (y/n)? "
read ANSWER
if [ $ANSWER == "y" ]
then
  echo "Deploying configuration files to ${HOME}..."
  deploy_configuration
else
  echo "Not doing anything. Exiting"
  exit
fi
