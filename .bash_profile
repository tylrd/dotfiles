#####################
# EXPORTS
#####################
export PAGER=${PAGER:-"less"}
export EDITOR="vim"
export VISUAL=$EDITOR

export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"

export RIPGREP_CONFIG_PATH="$HOME/.rgrc"

#don't check mail when opening terminal.
unset MAILCHECK

# make the "sudo" prompt more useful, without requiring access to "visudo"
export SUDO_PROMPT=${SUDO_PROMPT:-"[sudo] password for %u on %h: "}

# larger bash history (allow 32³ entries; default is 500)
export HISTSIZE=${HISTSIZE:-32768} # resize history size
export HISTFILESIZE=$HISTSIZE

# https://unix.stackexchange.com/questions/1288/preserve-bash-history-in-multiple-terminal-windows
# Avoid duplicates
export HISTCONTROL=ignoreboth:erasedups
# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend

# After each command, append to the history file and reread it
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# make some commands not show up in history
export HISTIGNORE=${HISTIGNORE:-"shutdown*:halt*:poweroff*:hibernate*:rm -rf*"}
export HISTTIMEFORMAT=${HISTTIMEFORMAT:-"%Y-%m-%d %H:%M:%S"}

export LS_COLORS='di=34' # directory  blue
LS_COLORS+=':ln=35'      # symlink    magenta
LS_COLORS+=':ex=31'      # executable red
LS_COLORS+=':st=0'       # sticky     normal

# Go variables
export GOPATH=$HOME/go

export PIPENV_VENV_IN_PROJECT=1

#####################
# PATH
#####################
export PATH="$HOME/.bin:$PATH"
export PATH="$GOPATH/bin:$PATH"
export PATH="$HOME/google-cloud-sdk/bin:$PATH"
export PATH="$HOME/n/bin:$PATH"

#####################
# COMPLETION
#####################
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  source $(brew --prefix)/etc/bash_completion
fi

if [ -f "$HOME/.local" ]; then source "$HOME/.local"; fi
if [ -f "$HOME/.secrets" ]; then source "$HOME/.secrets"; fi
if [ -f "$HOME/.git-completion.bash" ]; then source "$HOME/.git-completion.bash"; fi
if [ -f "$HOME/.fzf.bash" ]; then source "$HOME/.fzf.bash"; fi
if [ -f "$HOME/google-cloud-sdk/completion.bash.inc" ]; then source "$HOME/google-cloud-sdk/completion.bash.inc"; fi

#####################
# PROMPT
#####################
source ~/.git_prompt.sh

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWCOLORHINTS=1

PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}__prompt_command;"

get_envs() {
  prompt=""
  local cyan='\[\e[1;36m\]'
  local green='\[\e[0;32m\]'

  KUBE_CONFIG_FILE=${KUBECONFIG:-"$HOME/.kube/config"}

  if [ -f "$KUBE_CONFIG_FILE" ]; then
    KUBE_CONTEXT=$(sed -n 's/current-context: \(.*\)/\1/p' $HOME/.kube/config | cut -d'_' -f4)

    if [ -n "$KUBE_CONTEXT" ]; then
      prompt+=" ${cyan}($KUBE_CONTEXT)"
    fi
  fi

  if [ -z "$GOOGLE_PROJECT" ] && [ -z "$CHEF_ENV" ]; then
    echo "$prompt"
    return
  fi

  if [ "$GOOGLE_PROJECT" = "$CHEF_ENV" ]; then
    prompt+=" ${cyan}[${GOOGLE_PROJECT}] $(printf '\xE2\x9C\xA8')"
  else
    if [ -n "$GOOGLE_PROJECT" ]; then
      prompt+=" ${green}( gcp: $GOOGLE_PROJECT )"
    fi

    if [ -n "$CHEF_ENV" ]; then
      prompt+=" ${green}( chef: $CHEF_ENV )"
    fi

  fi

  echo "$prompt"
}

__prompt_command() {
    local curr_exit="$?"
    PS1=""

    local RCol='\[\e[0m\]'
    local BYel='\[\e[1;33m\]'
    local Red='\[\e[0;31m\]'
    local Blu='\[\e[0;34m\]'

    if [ "$curr_exit" != 0 ]; then
        PS1+="${Red}\u${RCol}"
    else
        PS1+="\u"
    fi

    pwd2=$(p="${PWD#${HOME}}"; [ "${PWD}" != "${p}" ] && printf "~";IFS=/; for q in ${p:1}; do printf /${q:0:1}; done; printf "${q:1}")

    PS1+="${RCol}@\h:${Blu}$pwd2${BYel}$(__git_ps1 " (%s)")$(get_envs) ${RCol}\n$ "
}

ssh-add -A &> /dev/null

#####################
# ALIASES
#####################
if which vim >/dev/null 2>&1; then
  alias vi="vim"
fi

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias fe_nginx='/usr/local/bin/nginx -c /usr/local/etc/nginx/nginx.conf.FE'

alias mkdir="mkdir -pv"
alias c="clear"
alias rm="rm -iv"
alias mkdir="mkdir -pv"
alias cp="cp -v"
alias mv="mv -v"
alias g="git"
alias grep="grep --color=auto"
alias vimrc="vim ~/.vimrc"
alias du="ncdu --color dark -rr -x --exclude .git --exclude node_modules"
alias dc="docker-compose"

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
alias kv="kubectl config current-context"
alias ksh="kubectl run -i --tty busybox --image=busybox -- sh"

# Google Cloud aliases
if command -v gcloud &> /dev/null; then
  alias gc="gcloud"
  alias gcp="gcloud config get-value project"
  alias gcps="gcloud config set project"
fi

alias tmux="TERM=screen-256color-bce tmux"

# kills all tmux sessions
alias kmux="tmux ls | awk '{ print \$1}' | tr -d ':' | xargs -I{} tmux kill-session -t {}"
alias mux="tmuxinator"

# Starts ephemeral session in tmux
alias eph="tmuxinator start ephemeral"
alias bc="tmuxinator start bettercloud"
alias fe="tmuxinator start fe"

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

#####################
# FUNCTIONS
#####################
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

mkd() {
  mkdir -p "$@"
  cd "$@" || exit
}

# converts RSA key to single line
convert_key() {
  sed s/$/\\\\n/ | tr -d '\n'
}

# kill all vagrant images
kvagrant() {
  vagrant global-status | awk '/running/{ print $1 }' | xargs vagrant destroy --force
}

gssh() {
  local ssh_user="$(cat "$HOME/.ephemeral/ssh_user")"
  local hostname

  if [ "$#" -lt 1  ]; then
    echo "Must provide 1 argument => hostname"
    return 1
  else
    hostname=$1
    shift
  fi

  local ssh_opts=(
  -o ForwardAgent=yes
  -o StrictHostKeyChecking=no
  -o UserKnownHostsFile=/dev/null
  )

  BASTION_IP=$(gcloud compute instances describe bastion --format="value(networkInterfaces[0].accessConfigs[0].natIP)")

  if [ -z "$BASTION_IP" ]; then
    echo "No bastion host found for $(gcloud config get-value project)"
    return 1
  fi

  local proxy_command="ssh ${ssh_opts[@]} %r@$BASTION_IP -W %h:%p"
  ssh "${ssh_opts[@]}" -o ProxyCommand="$proxy_command" $ssh_user@$hostname "$@"
}

gscp() {
  local ssh_user="$(cat "$HOME/.ephemeral/ssh_user")"
  local hostname

  local ssh_opts=(
  -q
  -o ForwardAgent=yes
  -o StrictHostKeyChecking=no
  -o UserKnownHostsFile=/dev/null
  )

  BASTION_IP=$(gcloud compute instances describe bastion --format="value(networkInterfaces[0].accessConfigs[0].natIP)")

  if [ -z "$BASTION_IP" ]; then
    echo "No bastion host found for $(gcloud config get-value project)"
    return 1
  fi

  local proxy_command="ssh ${ssh_opts[@]} %r@$BASTION_IP -W %h:%p"
  scp "${ssh_opts[@]}" -o ProxyCommand="$proxy_command" "$@"
}

glist() {
  echo "Instances for project: $(gcloud config get-value project)..."

  if [ "$#" -eq 0 ]; then
    gcloud compute instances list
  else
    gcloud compute instances list "$@"
  fi
}

cook() {
  local chef_env

  if [ -n "$1" ]; then
    chef_env=$1
  else
    chef_env=$(gcloud config get-value project)
  fi

  if [ ! -d "$HOME/.chef/$chef_env"  ]; then
    echo "Not a valid option for cooking! No directory found: $HOME/.chef/$chef_env"
    return 1
  fi

  echo "You are now cooking with $chef_env! $(printf '\xF0\x9F\x8D\xB2')"
  export CHEF_ENV=$chef_env
}

gshow() {
  git show $(git log --pretty=oneline | fzf | cut -d=' ' -f1)
}

# Search for file with fzf and then open it in an editor
# If inside git directory, search in entire git repository
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

# Change directory into top level git directory
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

bind -x '"\C-f": findpod'

showcert() {
  if [ -z "$1" ]; then
    "Usage: showcert /path/to/cert.pem"
    return
  fi

  openssl x509 -in $1 -noout -text
}
