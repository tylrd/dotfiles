#####################
# EXPORTS
#####################
export IGNOREEOF=10
export PAGER=${PAGER:-"less"}
export EDITOR="vim"
export VISUAL=$EDITOR

export FZF_DEFAULT_OPTS='--height 60% --layout=reverse'
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"

export RIPGREP_CONFIG_PATH="$HOME/.rgrc"

##don't check mail when opening terminal.
#unset MAILCHECK

## make the "sudo" prompt more useful, without requiring access to "visudo"
export SUDO_PROMPT=${SUDO_PROMPT:-"[sudo] password for %u on %h: "}

## larger bash history (allow 32³ entries; default is 500)
export HISTSIZE=${HISTSIZE:-32768} # resize history size
export HISTFILESIZE=$HISTSIZE

## https://unix.stackexchange.com/questions/1288/preserve-bash-history-in-multiple-terminal-windows
## Avoid duplicates
export HISTCONTROL=ignoreboth:erasedups

## When the shell exits, append to the history file instead of overwriting it
shopt -s histappend

## After each command, append to the history file and reread it
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

## make some commands not show up in history
export HISTIGNORE=${HISTIGNORE:-"shutdown*:halt*:poweroff*:hibernate*:rm -rf*"}
#export HISTTIMEFORMAT=${HISTTIMEFORMAT:-"%Y-%m-%d %H:%M:%S"}

#export LS_COLORS='di=34' # directory  blue
#LS_COLORS+=':ln=35'      # symlink    magenta
#LS_COLORS+=':ex=31'      # executable red
#LS_COLORS+=':st=0'       # sticky     normal

## Go variables
export GOPATH=$HOME/go

######################
## PATH
######################
export PATH="$HOME/.bin:$PATH"
export PATH="$GOPATH/bin:$PATH"
export PATH="$HOME/google-cloud-sdk/bin:$PATH"
export PATH="$HOME/n/bin:$PATH"

######################
## COMPLETION
######################
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  source $(brew --prefix)/etc/bash_completion
fi

if [ -f "$HOME/.local" ]; then source "$HOME/.local"; fi
if [ -f "$HOME/.secrets" ]; then source "$HOME/.secrets"; fi
if [ -f "$HOME/.git-completion.bash" ]; then source "$HOME/.git-completion.bash"; fi
if [ -f "$HOME/.fzf.bash" ]; then source "$HOME/.fzf.bash"; fi
if [ -f "$HOME/google-cloud-sdk/completion.bash.inc" ]; then source "$HOME/google-cloud-sdk/completion.bash.inc"; fi

######################
## PROMPT
######################
source ~/.git_prompt.sh

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWCOLORHINTS=1

__kube_ps1() {
  KUBE_CONFIG_FILE=${KUBECONFIG:-"$HOME/.kube/config"}

  if [ -f "$KUBE_CONFIG_FILE" ]; then
    KUBE_CONTEXT=$(sed -n 's/current-context: \(.*\)/\1/p' $KUBE_CONFIG_FILE | cut -d'_' -f4)
  fi

  if [ -z "$KUBE_CONTEXT" ]; then
    echo
  else
    # NAMESPACE=$(kubectl config view --minify --output 'jsonpath={..namespace}')
    echo "$KUBE_CONTEXT"
  fi
}

PS1='\[\e[0m\]\h \W\[\e[1;33m\]$(__git_ps1 " (%s)") \[\e[1;36m\]$(__kube_ps1)\[\e[0m\]\n$ '

######################
## ALIASES
######################
if which vim >/dev/null 2>&1; then
  alias vi="vim"
fi

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

alias mkdir="mkdir -pv"
alias c="clear"
alias rm="rm -iv"
alias mkdir="mkdir -pv"
alias cp="cp -v"
alias mv="mv -v"
alias grep="grep --color=auto"
alias vimrc="vim ~/.vimrc"
alias du="ncdu --color dark -rr -x --exclude .git --exclude node_modules"

# Insecure ssh; only use this for sites you **DEFINITELY** trust
# Seriously...
alias issh="ssh -q -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ForwardAgent=yes"

# pretty-print path
alias path="echo \"${PATH//:/$'\n'}\""

# Starts web server that serves cwd
alias srv="python3 -m http.server --bind=127.0.0.1"

alias tf="terraform"
alias t="tmux"
alias tkill="tmux kill-session -t"

alias k="kubectl"
alias kx="kubectx"
alias kn="kubens"

kc(){
    export KUBECONFIG=$(mktemp -t kubeconfig)
    cat ~/.kube/config >> $KUBECONFIG
    kubectx
}

# alias kv="kubectl config current-context"
# alias ksh="kubectl run -i --tty busybox --image=busybox -- sh"

# Google Cloud aliases
if command -v gcloud &> /dev/null; then
  alias gc="gcloud"
  alias gcp="gcloud config get-value project"
  alias gcps="gcloud config set project"
fi

alias tmux="TERM=screen-256color-bce tmux"

# kills all tmux sessions
alias kmux="tmux ls | awk '{ print \$1}' | tr -d ':' | xargs -I{} tmux kill-session -t {}"

# Starts ephemeral session in tmux
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
alias lsport='sudo lsof -i -T -n'

alias date_iso_8601='date "+%Y%m%dT%H%M%S"'

alias meminfo="free -m -l -t"
alias psx="ps auxwf | grep "
alias pst="pstree -Alpha"

# OS X has no `md5sum`, so use `md5` as a fallback
command -v md5sum > /dev/null || alias md5sum="md5"

# OS X has no `sha1sum`, so use `shasum` as a fallback
command -v sha1sum > /dev/null || alias sha1sum="shasum"

if [[ "$SYSTEM_TYPE" == "OSX" ]]; then  # Is this the Ubuntu system?
    alias ls="gls -F --color=auto"
    alias date="gdate"
fi

COLORFLAG="-G"
alias ls='/usr/local/bin/gls --color -lash --group-directories-first'
alias la="ls"
alias ll="ls"

######################
## FUNCTIONS
######################
function bclone() {
  git clone "git@bitbucket.org:bettercloud/$1.git" --branch continuous
}

function killp () {
  if (( $# == 0 ))
  then
    echo usage: killp portNumber1 portNumber2 ...
  else
    for i; do
      PROCESS=$(lsof -t -i:$i)
      if [[ $PROCESS ]]; then
        kill -9 $PROCESS
        echo "killed process $PROCESS"
      else
        echo "No process found for port $i"
      fi
    done
  fi
}

## kill all vagrant images
kvagrant() {
  vagrant global-status | awk '/running/{ print $1 }' | xargs vagrant destroy --force
}

## Search for file with fzf and then open it in an editor
## If inside git directory, search in entire git repository
fzf_then_open_in_editor() {
  local file

  if git rev-parse --git-dir > /dev/null 2>&1; then
    file=$(fd --hidden --exclude .git --type f . $(git rev-parse --show-cdup | sed 's:/*$::') | fzf --height 40%)
  else
    file=$(fzf --height 40%)
  fi

  if [ -n "$file" ]; then
    file="$(realpath "$file")"
    history -s "vim $file"
    ${EDITOR:-vim} "$file"
  fi
}

bind -x '"\C-t": fzf_then_open_in_editor'

cdf() {
  local file

  if git rev-parse --git-dir > /dev/null 2>&1; then
    file=$(fd --type d . $(git rev-parse --show-cdup) | sed 's:/*$::' \
      | fzf --height 40% +m -q "$1")
  else
    file=$(fd --type d . | fzf --height 40% +m -q "$1")
  fi

  if [ ! -d "$file" ]; then
    file=$(dirname "$file")
  fi

  history -s "cd $file"
  cd "$file"
}

bind -x '"\C-p": cdf'

## Change directory into top level git directory
cdup() {
  if git rev-parse --git-dir > /dev/null 2>&1; then
    cdup="$(git rev-parse --show-cdup)" && cd "${cdup:-.}"
  else
    echo "Not in git directory!"
  fi
}

fzf_search_and_open() {
  if git rev-parse --git-dir > /dev/null 2>&1; then
    line=$(rg --with-filename --no-heading --line-number ${1:-''} $(git rev-parse --show-cdup | sed 's:/*$::') | fzf)
  else
    line=$(rg --with-filename --no-heading --line-number ${1:-''} | fzf)
  fi

  if [ -n "$line" ]; then
    file=$(cut -d':' -f1 <<< "$line")
    line=$(cut -d':' -f2 <<< "$line")
    history -s "vim $file +$line"
    ${EDITOR:-vim} $file +$line
  fi
}

bind -x '"\C-f": fzf_search_and_open'

#showcert() {
#  if [ -z "$1" ]; then
#    "Usage: showcert /path/to/cert.pem"
#    return
#  fi

