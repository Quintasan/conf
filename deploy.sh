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
  echo "Sleeping for 5 seconds"
  sleep 5
  echo "Fetching the configuration files from GitHub"
  git clone https://github.com/Quintasan/conf.git $HOME/conf
  cd $HOME/conf

  echo "Fetching submodules"
  git submodule init
  git submodule update

  echo "Symlinking ${HOME}/conf/.zshrc to ${HOME}/.zshrc"
  ln -s $HOME/conf/.zshrc $HOME/.zshrc
  echo "Symlinking ${HOME}/conf/vimconf/.vimrc to ${HOME}/.vimrc"
  ln -s $HOME/conf/vimconf/.vimrc $HOME/.vimrc
  echo "Please start vim to fetch plugins"
  echo "Symlinking ${HOME}/conf/.vimrc.last to ${HOME}/.vimrc.last"
  ln -s $HOME/conf/.vimrc.last $HOME/.vimrc.last
  echo "Symlinking ${HOME}/conf/.gitconfig to ${HOME}/.gitconfig"
  ln -s ${HOME}/conf/.gitconfig ${HOME}/.gitconfig
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
