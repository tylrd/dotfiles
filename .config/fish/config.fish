# Turn this on for debugging
# set fish_trace true

set -U fish_greeting

if status --is-login
  set -gx PATH $HOME/.pyenv/bin $HOME/.local/bin /opt/homebrew/bin $HOME/google-cloud-sdk/bin $PATH
  pyenv init - | source
end

set -gx EDITOR nvim
set -gx FZF_DEFAULT_OPTS '--cycle --layout=reverse --border --height=90% --preview-window=wrap --marker="*" --keep-right'
set -gx FZF_DEFAULT_COMMAND 'fd --type f'

set fish_cursor_insert line
# set -U nvm_default_version 14

alias vim="nvim"
alias vi="nvim"
alias v="nvim"
alias k="kubectl"
alias ls='gls --color -lash --group-directories-first'

fish_vi_key_bindings
fzf_configure_bindings --directory=\cf

set fzf_fd_opts --type f
set --export fzf_dir_opts --bind "ctrl-v:execute(SHELL=sh nvim {} &> /dev/tty)"

alias fishcnf="vim ~/.config/fish/config.fish && source ~/.config/fish/config.fish"
alias kittycnf="vim ~/.config/kitty/kitty.conf"
alias vimcnf="vim ~/.config/nvim/init.lua"

function fzf_dir
  set dir $(fd --type d | fzf)

  if test -n $dir
    echo $dir
    commandline "cd $dir"
    commandline -f execute
  else
    echo "empty"
    return
  end
end

function fish_user_key_bindings
  for mode in default insert visual
    bind -M $mode \e\[A history-prefix-search-backward
    bind -M $mode \co forward-char
    bind -M $mode \cp fzf_dir
  end
end

function java_home
  set -gx JAVA_HOME $(/usr/libexec/java_home -v $argv[1])
  java -version
end

alias j8="java_home 1.8"
alias j11="java_home 11"
alias j17="java_home 17"
