# Turn this on for debugging
# set fish_trace true

set -U fish_greeting

if status --is-login
  echo "Detecing login shell, initializing PATH..."
  set -gx PATH $HOME/.pyenv/bin $HOME/.local/bin /opt/homebrew/bin $HOME/google-cloud-sdk/bin /opt/homebrew/opt/libpq/bin $PATH
  pyenv init - | source
end

set -gx EDITOR nvim
set -gx FZF_DEFAULT_OPTS '--cycle --layout=reverse --border --height=90% --preview-window=wrap --marker="*" --keep-right'
set -gx FZF_DEFAULT_COMMAND 'fd --type f'

set fish_cursor_insert line
set -U nvm_default_version 20
set -U nvm_default_packages @fsouza/prettierd yarn

status --is-interactive; and rbenv init - fish | source

alias vim="nvim"
alias vi="nvim"
alias v="nvim"
alias k="kubectl"
alias ls='gls --color -lash --group-directories-first'

fish_vi_key_bindings
fzf_configure_bindings --directory=\cf

set fzf_fd_opts --type f
set --export fzf_dir_opts --bind "enter:execute(nvim {} &> /dev/tty)" --bind "ctrl-v:execute(nvim {} &> /dev/tty)"

alias fishcnf="vim ~/.config/fish/config.fish && source ~/.config/fish/config.fish"
alias kittycnf="vim ~/.config/kitty/kitty.conf"
alias vimcnf="vim ~/.config/nvim/init.lua"

function fzf_dir
  set dir $(fd --type d | fzf)

  if string length -q -- $dir
    commandline "cd $dir"
    commandline -f execute
  end

  commandline -f repaint
end

function search
  set rg_prefix "rg --color=always --smart-case --no-heading --with-filename --line-number --sort path"
  fzf \
    --ansi \
    --disabled \
    --delimiter : \
    --bind "start:reload:$rg_prefix '' | cut -d: -f1,2" \
    --bind "change:reload:$rg_prefix {q} | cut -d: -f1,2 || true" \
    --preview='bat --color=always {1} --highlight-line {2}' \
    --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
    --bind 'enter:become(nvim {1} +{2})'

  commandline -f repaint
end

function fish_user_key_bindings
  for mode in default insert visual
    bind -M $mode \e\[A history-prefix-search-backward
    bind -M $mode \co forward-char
    bind -M $mode \cp fzf_dir
    bind -M $mode \cg search
  end
end

function java_home
  set -gx JAVA_HOME $(/usr/libexec/java_home -v $argv[1])
  java -version
end

function cdup
  set -l is_git_repository (git rev-parse --is-inside-work-tree)

  if test -n "$is_git_repository"
    cd $(git rev-parse --show-cdup)
  end
end

alias j8="java_home 1.8"
alias j11="java_home 11"
alias j17="java_home 17"

