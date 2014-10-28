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
  echo "Symlinking ${HOME}/conf/vimrc.bundles to ${HOME}/.vimrc.bundles"
  ln -fs ${HOME}/conf/vimrc.bundles ${HOME}/.vimrc.bundles
  echo "Symlinking ${HOME}/conf/vimrc.last to ${HOME}/.vimrc.last"
  ln -fs ${HOME}/conf/vimrc.last ${HOME}/.vimrc.last
  echo "Please start vim to fetch plugins"
  echo "Grab sum patched fonts"
  mkdir -p ${HOME}/.fonts/p
  wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf -O ${HOME}/.fonts/p/PowerLineSymbols.otf
  mkdir -p ${HOME}/.config/fontconfig/conf.d/
  wget https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf -O ${HOME}/.config/fontconfig/conf.d/10-powerline-symbols.conf
  fc-cache -vf ${HOME}/.fonts
  echo "Symlinking ${HOME}/conf/gitconfig to ${HOME}/.gitconfig"
  ln -fs ${HOME}/conf/gitconfig ${HOME}/.gitconfig
  echo "Symlinking ${HOME}/conf/ssh/config to ${HOME}/.ssh/config"
  mkdir -p ${HOME}/.ssh
  mkdir -p %{HOME}/.ssh/multiplex
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
