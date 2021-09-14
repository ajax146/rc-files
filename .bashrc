######################
# Interactive Checks #
######################

case $- in
    *i*) ;;
      *) return;; esac

[ -z "$PS1" ] && return

export TERM=xterm
set -o vi

########
# Path #
########

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/opt:/usr/share/games:/snap/bin:~/bin

###########
# History #
###########

HISTCONTROL=ignoredups:ignorespace
shopt -s histappend
shopt -s cdspell
HISTSIZE=1000
HISTFILESIZE=2000

###############
# Winsize fix #
###############
shopt -s checkwinsize

############
# Colorize #
############
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -ah --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

#################
# Auto Complete #
#################

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#########
# Utils #
#########

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

###########
# Aliases #
###########
alias sc='source ~/.bashrc'
alias ll='ls -lahF'
alias lr='ls -aR'
alias psg='ps -e | grep -i '
alias iptables-save='sudo iptables-save -f /etc/iptables/iptables.rules'
alias iptables-view='sudo iptables -nL --line-numbers'
alias editsc='nano ~/.bashrc'
alias sshkey='cat ~/.ssh/id_rsa.pub'
alias ips='ip a;ip r'
alias pub='curl ifconfig.me/ip'
alias init='apt update -y ; apt update -y ; apt install -y sudo vim neofetch nmap dnsutils sshfs wget curl zip unzip iptables git htop ; apt upgrade -y ; reboot'
alias apg='apt list --installed | grep '

##########################
# System specific changes#
##########################

source ~/.customrc

#########
# Start #
#########

cd ~
neofetch
