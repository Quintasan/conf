_has() {
  return $( whence $1 >/dev/null )
}
_append_to_path() {
  if [ -d $1 -a -z ${path[(r)$1]} ]; then
    path=($1 $path);
  fi
}

if [ -e "$HOME/.local/bin" ]; then
  _append_to_path "$HOME/.local/bin"
fi

if [ -e "$HOME/.rbenv" ]; then
  _append_to_path $HOME/.rbenv/bin
fi

if [ -e "$HOME/.asdf" ]; then
  source "$HOME/.asdf/asdf.sh"
  fpath=(${ASDF_DIR}/completions $fpath)
  autoload -Uz compinit
  compinit
fi

if [ -e /media/dump/quintasan/bin/android-sdk/platform-tools/ ]; then
  _append_to_path /media/dump/quintasan/bin/android-sdk/platform-tools/
fi

if [ -e /snap/bin ]; then
  _append_to_path /snap/bin
fi

if [ -e $HOME/.cargo/bin ]; then
  _append_to_path $HOME/.cargo/bin
fi

if [ -e ~/.fzf ]; then
  _append_to_path ~/.fzf/bin
  source ~/.fzf/shell/key-bindings.zsh
  source ~/.fzf/shell/completion.zsh
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
SPACESHIP_PROMPT_ORDER=(
  time          # Time stamps section
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  #hg            # Mercurial section (hg_branch  + hg_status)
  #package       # Package version
  node          # Node.js section
  ruby          # Ruby section
  elixir        # Elixir section
  #xcode         # Xcode section
  swift         # Swift section
  golang        # Go section
  #php           # PHP section
  rust          # Rust section
  haskell       # Haskell Stack section
  #julia         # Julia section
  #docker        # Docker section
  #aws           # Amazon Web Services section
  venv          # virtualenv section
  #conda         # conda virtualenv section
  #pyenv         # Pyenv section
  #dotnet        # .NET section
  #ember         # Ember.js section
  #kubecontext   # Kubectl context section
  #terraform     # Terraform workspace section
  #exec_time     # Execution time
  #line_sep      # Line break
  battery       # Battery level and status
  #vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
  )
ZSH_THEME="spaceship"
export UPDATE_ZSH_DAYS=14
export DISABLE_CORRECTION="true"
export ANDROID_HVPROTO=ddm
export EDITOR=vim
COMPLETION_WAITING_DOTS="true"
plugins=(cp colorize colored-man-pages pass bundler docker httpie tmuxinator zsh-syntax-highlighting zsh-autosuggestions)
alias mux="tmuxinator"
alias database="docker run -d --name playground -p 5432:5432 -e POSTGRES_USER=playground -e POSTGRES_PASSWORD=playground -d postgres:12-alpine"

source $ZSH/oh-my-zsh.sh

alias dcr="docker-compose run --rm"
alias clipboard="xclip -selection clipboard"

# Custom stuff

alias dcr="docker-compose run --rm"

function mkcd() {
  mkdir $1 && cd $1
}
autoload mkcd

cd .

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fpath=(~/.zsh/completion $fpath)
eval "$(rbenv init -)"
