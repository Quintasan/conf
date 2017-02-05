export PATH=$HOME/.local/bin:$HOME/bin:$PATH
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
[[ -s "$HOME/.asdf/asdf.sh" ]] && source "$HOME/.asdf/asdf.sh"
[[ -s "$HOME/.asdf/completions/asdf.bash" ]] && . $HOME/.asdf/completions/asdf.bash

# Set up oh-my-zsh
ZSH=$HOME/conf/oh-my-zsh
ZSH_THEME="bira"
export UPDATE_ZSH_DAYS=14
export DISABLE_CORRECTION="true"
export ANDROID_HVPROTO=ddm
export EDITOR=vim
COMPLETION_WAITING_DOTS="true"
plugins=(cp colorize colored-man-pages pass rvm tmuxinator)

alias mux="tmuxinator"
alias database="docker run -d --name playground -p 5432:5432 -e POSTGRES_USER=playground -e POSTGRES_PASSWORD=playground -d postgres:9.6-alpine"

source $ZSH/oh-my-zsh.sh

# Custom stuff
function mkcd() {
  mkdir $1 && cd $1
}
autoload mkcd

cd .
