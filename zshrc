_has() {
  return $( whence $1 >/dev/null )
}
_append_to_path() {
  if [ -d $1 -a -z ${path[(r)$1]} ]; then
    path=($1 $path);
  fi
}
export PATH=$HOME/.local/bin:$HOME/bin:$PATH
if [ -e "$HOME/.rbenv" ]; then
  _append_to_path $HOME/.rbenv/bin
fi
if [ -e ~/.fzf ]; then
  _append_to_path ~/.fzf/bin
  source ~/.fzf/shell/key-bindings.zsh
  source ~/.fzf/shell/completion.zsh
fi
if [ -e /usr/lib/go-1.8/bin/ ]; then
  _append_to_path /usr/lib/go-1.8/bin/
fi
if _has fzf && _has ag; then
  export FZF_DEFAULT_COMMAND='ag --nocolor -g ""'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_DEFAULT_OPTS='
  --color fg:242,bg:236,hl:65,fg+:15,bg+:239,hl+:108
  --color info:108,prompt:109,spinner:108,pointer:168,marker:168
  '
fi
# Set up oh-my-zsh
ZSH=$HOME/conf/oh-my-zsh
ZSH_THEME="bira"
export UPDATE_ZSH_DAYS=14
export DISABLE_CORRECTION="true"
export ANDROID_HVPROTO=ddm
export EDITOR=vim
COMPLETION_WAITING_DOTS="true"
plugins=(cp colorize colored-man-pages pass asdf bundler docker httpie tmuxinator)
alias mux="tmuxinator"
alias database="docker run -d --name playground -p 5432:5432 -e POSTGRES_USER=playground -e POSTGRES_PASSWORD=playground -d postgres:9.6-alpine"

source $ZSH/oh-my-zsh.sh

alias dcr="docker-compose run --rm"

# Custom stuff
function mkcd() {
  mkdir $1 && cd $1
}
autoload mkcd

cd .

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(rbenv init -)"
