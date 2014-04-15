#RVM needs to be loaded before oh-my-zsh
export PATH=$PATH:$HOME/.rvm/bin

# Set up oh-my-zsh
ZSH=$HOME/conf/oh-my-zsh
ZSH_THEME="bira"
export UPDATE_ZSH_DAYS=14
export DISABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
plugins=(debian command-not-found cp rvm)

source $ZSH/oh-my-zsh.sh

# Custom stuff
function mkcd() {
  mkdir $1 && cd $1
}
autoload mkcd
