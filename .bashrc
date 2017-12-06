#############################################
#                                           #
# This is a bash and zsh compatible script. #
#                                           #
#############################################

if [[ "$TERM" == "xterm"* ]]; then
  export TERM=xterm-256color
elif [[ "$TERM" == "screen"* ]]; then
  export TERM=screen-256color
fi

whichTTY=$(tty | sed -e "s:/dev/::")
if [ $(command -v tmux) ] ; then
  if [[ $TERM != screen* ]] && [[ $whichTTY == pts* || $whichTTY == tty1 || $whichTTY == pty* || $whichTTY == ttyv0 || $whichTTY == ttys00* ]] ; then
    cd ~
    # Check if fbterm installed
    if [ $(command -v fbterm) ] ; then
      exec fbterm -- bash -c 'TERM=fbterm exec tmux'
    elif [[ $whichTTY == pts* || $whichTTY == tty1 || $whichTTY == pty* || $whichTTY == ttyv0 || $whichTTY == ttys00* ]] ; then
      # If fbterm is not available
      exec tmux
    fi
  fi
elif [ $(command -v zsh) ] && ! [[ -n "$ZSH_VERSION" ]] ; then
  # If tmux is not available
  exec zsh
fi

export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_PAPER="en_US.UTF-8"
export LC_NAME="en_US.UTF-8"
export LC_ADDRESS="en_US.UTF-8"
export LC_TELEPHONE="en_US.UTF-8"
export LC_MEASUREMENT="en_US.UTF-8"
export LC_IDENTIFICATION="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export VISUAL="vim"
export EDITOR="$VISUAL"

alias upgradeMindot="cd ~/mindot && git pull origin master && cd -"
alias ll='ls -lh'
alias ls='ls -F --color=auto --show-control-chars'

# grep command without vcs folders
GREP_OPTIONS=""
if $(echo | grep --color=auto "" > /dev/null 2>&1); then
  GREP_OPTIONS="$GREP_OPTIONS --color=auto"
fi
VCS_FOLDERS="{.bzr,CVS,.git,.hg,.svn}"
if $(echo | grep --exclude-dir=.cvs "" > /dev/null 2>&1); then
  GREP_OPTIONS="$GREP_OPTIONS --exclude-dir=$VCS_FOLDERS"
elif $(echo | grep --exclude=.cvs "" > /dev/null 2>&1); then
  GREP_OPTIONS="$GREP_OPTIONS --exclude=$VCS_FOLDERS"
fi
alias grep="grep $GREP_OPTIONS"

stty -ixon -ixoff # In order to use Ctrl Q and ctrl S in vim
stty lnext '^-' stop undef start undef -ixon # In order to use Ctrl V in vim

if [[ -n "$ZSH_VERSION" ]]; then # Zsh
  alias -g ...='../..'
  alias -g ....='../../..'
  export HISTSIZE=10000
  export SAVEHIST=10000
  WORDCHARS='' # More completion
  bindkey -e # Emacs keys
  unsetopt flowcontrol # Unbind Ctrl-S
  unsetopt menu_complete # Don't autoselect the first completion entry
  autoload -U +X compinit && compinit
  autoload -U +X colors && colors
  zmodload -i zsh/complist
  zstyle ':completion:*:*:*:*:*' menu select# selected entry highlighting
  zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*' # Case insensitive
  zstyle '*' single-ignored show # Don't show menu when there is only one match
  zstyle ':completion:*' list-colors '' # Popup colors
  NEWLINE_NO_OMZ=$'\n'
  # Minimal zsh theme
  PROMPT="%B%F{red}%n%B%F{yellow}@%B%F{green}%M %{$reset_color%}➜ %B%F{blue}%~"${NEWLINE_NO_OMZ}"%{$reset_color%}$ "
  export KEYTIMEOUT=1 # Make ESC faster
  setopt NO_NOMATCH # disable zsh match filename
  setopt complete_in_word # Move cursor to the end when completion
  setopt always_to_end # Move cursor to the end when completion
  setopt nonomatch # Disable warning when completion not found
  _comp_options+=(globdots) # Show hidden files when using completion
  HISTFILE=$HOME/.bash_history # Share history with bash
  alias history='fc -ln 1' # bash-like history
  unsetopt EXTENDED_HISTORY # Use bash-like history
  unsetopt SHARE_HISTORY # Use bash-like history
  unsetopt INC_APPEND_HISTORY_TIME # Use bash-like history
  unsetopt AUTOCD # Don't cd to the directory by just typing its name
  setopt INC_APPEND_HISTORY # Use bash-like history

  # alt + arrow key to move
  bindkey "^[[1;3C" forward-word
  bindkey "^[[1;3D" backward-word
  bindkey "^[[1;5C" forward-word
  bindkey "^[[1;5D" backward-word
  bindkey "\e\eOC" forward-word
  bindkey "\e\eOD" backward-word
  bindkey "\e\e[C" forward-word
  bindkey "\e\e[D" backward-word

  # Up/Down keys for searching history
  bindkey "\e\eA" up-line-or-search
  bindkey "\e\eB" down-line-or-search
  bindkey "^[[A" up-line-or-search
  bindkey "^[[B" down-line-or-search

  bindkey "^N" forward-word
  bindkey "^P" backward-word
  bindkey "^B" backward-kill-word
  bindkey '^A' beginning-of-line
  bindkey '^E' end-of-line
  bindkey '^R' history-incremental-search-backward
  bindkey "\e\e^H" backward-kill-word # Alt + Backspace
  bindkey "^[^?" backward-kill-word # Alt + Backspace
  bindkey "\e\C-?" backward-kill-word # Alt + Backspace
  bindkey "^Z" undo
  bindkey "^Y" redo
elif [[ -n "$BASH_VERSION" ]]; then # Bash
  complete -cf sudo # complete sudo command
  complete -cf man # complete man command
  # Get bash completion
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
  elif [ -f /usr/local/share/bash-completion/bash_completion.sh ]; then
    source /usr/local/share/bash-completion/bash_completion.sh
  elif [ -f /usr/local/share/bash-completion/bash_completion ]; then
    source /usr/local/share/bash-completion/bash_completion
  elif [ -d "/usr/local/etc/bash_completion.d" ]; then # FreeBSD
    for f in /usr/local/etc/bash_completion.d/*; do
      source $f
    done
  fi
  export HISTCONTROL=ignoredups:erasedups # Ignore duplicate entries in .bash_history
  export HISTFILESIZE=
  export HISTSIZE=
  shopt -s histappend # Append history
  PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND" # Write history immediately
  bind 'set completion-ignore-case on' # Ignore case
  bind '"\e[A": history-search-backward' # Up key is searching backward
  bind '"\e[B": history-search-forward'  # Down key is searching forward
  bind '\C-B:backward-kill-word'
  bind '\C-Z:undo'
  bind '\C-Y:redo'
  bind 'set show-all-if-ambiguous on'
  export COLOR_RESET="\[$(tput sgr0)\]" # No Color
  export COLOR_RED="\[$(tput setaf 1)\]"
  export COLOR_GREEN="\[$(tput setaf 2)\]"
  export COLOR_YELLOW="\[$(tput setaf 3)\]"
  export COLOR_BLUE="\[$(tput setaf 4)\]"
  export COLOR_PURPLE="\[$(tput setaf 5)\]"
  export COLOR_CYAN="\[$(tput setaf 6)\]"
  export COLOR_GRAY="\[$(tput setaf 7)\]"
  export COLOR_LIGHT_RED="\[$(tput setaf 1; tput bold)\]"
  export COLOR_LIGHT_GREEN="\[$(tput setaf 2; tput bold)\]"
  export COLOR_LIGHT_YELLOW="\[$(tput setaf 3; tput bold)\]"
  export COLOR_LIGHT_BLUE="\[$(tput setaf 4; tput bold)\]"
  export COLOR_LIGHT_PURPLE="\[$(tput setaf 5; tput bold)\]"
  export COLOR_LIGHT_CYAN="\[$(tput setaf 6; tput bold)\]"
  export COLOR_LIGHT_GRAY="\[$(tput setaf 7; tput bold)\]"
  # Minimal bash theme, USER@DOMAIN directory
  export PS1="${COLOR_LIGHT_RED}\u${COLOR_LIGHT_YELLOW}@${COLOR_LIGHT_GREEN}\h${COLOR_RESET}➜ ${COLOR_LIGHT_BLUE}\w${COLOR_RESET}\n\$ "
fi
