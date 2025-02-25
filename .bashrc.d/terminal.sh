#!/bin/sh

# Calculate a short checksum of the real hostname to determine a unique color
#if [[ $TERM =~ "256color" ]]; then
    #host_color="38;5;$((16 + $(hostname | cksum | cut -c1-3) % 230))";
#else
    #host_color="1;$((31 + $(hostname | cksum | cut -c1-3) % 6))";
#fi
# for ((x=0; x<=255; x++));do echo -e "${x}:\033[38;5;${x}mcolor\033[000m";done

case "$TERM" in
	xterm*|rxvt*|screen*)
    if [ `id -u` = 0 ]; then
        PS1='\[\033[0;31m\]\h\[\033[00m\] \[\033[00m\]\w\[\033[00m\] \$ '
    else
        PS1='\[\033[0;32m\]\u@\h\[\033[00m\] \[\033[00m\]\w\[\033[00m\] \$ '
    fi
    TITLEBAR='\[\033]0;\u@\h:\w\007\]'
	;;
	*)
	;;
esac
HISTCONTROL=ignoreboth
shopt -s checkwinsize
shopt -s histappend

# Disable Ctrl-S
stty stop '' 2>/dev/null || true

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# make history more friendly
bind '"\e[A":history-search-backward' 2>/dev/null  || true
bind '"\e[B":history-search-forward' 2>/dev/null   || true


