set -U fish_greeting

set -gx PATH /opt/homebrew/bin $HOME/.local/bin $HOME/google-cloud-sdk/bin $PATH
set -gx EDITOR nvim
set -gx FZF_DEFAULT_OPTS '--cycle --layout=reverse --border --height=90% --preview-window=wrap --marker="*" --keep-right'
set -gx FZF_DEFAULT_COMMAND 'fd --type f'

set fish_cursor_insert line

alias vim="nvim"
alias vi="nvim"
alias v="nvim"
alias k="kubectl"
alias ls='gls --color -lash --group-directories-first'

fish_vi_key_bindings
fzf_configure_bindings --directory=\cf

alias fishcnf="vim ~/.config/fish/config.fish && source ~/.config/fish/config.fish"
alias kittycnf="vim ~/.config/kitty/kitty.conf"

function fish_user_key_bindings
    for mode in default insert visual
		bind -M $mode \e\[A history-prefix-search-backward
		bind -M $mode \co forward-char
    end
end

function java_home
	set -gx JAVA_HOME $(/usr/libexec/java_home -v $argv[1])
	java -version
end

alias j8="java_home 1.8"
alias j11="java_home 11"
alias j17="java_home 17"
