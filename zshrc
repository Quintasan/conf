export PATH=$HOME/.local/bin:$HOME/bin:$PATH
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# Set up oh-my-zsh
ZSH=$HOME/conf/oh-my-zsh
ZSH_THEME="bira"
export UPDATE_ZSH_DAYS=14
export DISABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
plugins=(cp colorize colored-man-pages vagrant pass rvm)

source $ZSH/oh-my-zsh.sh

# Custom stuff
function mkcd() {
  mkdir $1 && cd $1
}
autoload mkcd

cd .
