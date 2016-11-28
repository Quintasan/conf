export TERM=xterm-256color
export PATH=$HOME/.local/bin:$HOME/bin:$PATH
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

#RVM needs to be loaded before oh-my-zsh
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
[[ -s "$HOME/.asdf/asdf.sh" ]] && source "$HOME/.asdf/asdf.sh"

# Set up oh-my-zsh
ZSH=$HOME/conf/oh-my-zsh
ZSH_THEME="bira"
export UPDATE_ZSH_DAYS=14
export DISABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
plugins=(cp colorize colored-man-pages vagrant pass rvm)

alias demonbane="ssh -p 6666 `curl -s https://abramowicz.org/currentip.html `"

source $ZSH/oh-my-zsh.sh

# Custom stuff
function mkcd() {
  mkdir $1 && cd $1
}
autoload mkcd

cd .
