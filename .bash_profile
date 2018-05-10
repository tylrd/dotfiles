for file in ~/{.load,.path,.prompt,.exports,.aliases,.functions}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file"
done

[ -f $HOME/.secrets ] && source $HOME/.secrets

BASE16_SHELL=$HOME/.config/base16-shell
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).
