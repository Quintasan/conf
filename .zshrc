ZSH=$HOME/conf/oh-my-zsh
ZSH_THEME="bira"
export UPDATE_ZSH_DAYS=10
export DISABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
plugins=(debian kate command-not-found cp rvm)

export EDITOR=vim
source $ZSH/oh-my-zsh.sh
source $HOME/.rvm/scripts/rvm
export PATH=$PATH:$HOME/.rvm/bin
alias exot=exit
alias dir="dir --color=auto"

function mkcd() {
  mkdir $1 && cd $1
}
autoload mkcd
