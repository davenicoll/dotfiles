# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
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

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi



# terraform shortcuts for openmoney
tfall() {
    cd ~/Source/PlatformEngineering/terraform/ 
    set +e
    ./scripts/init.sh 
    ./scripts/plan.sh
    if [[ $? -eq 2 ]] || [[ "$2" == "config" ]]; then
        # If there's an error whilst running apply, halt this script (set -e)
        set -e
        ./scripts/apply.sh
    fi
    set -e
}
alias tfapply='cd ~/Source/PlatformEngineering/terraform/ && ./scripts/apply.sh'
alias tfinit='cd ~/Source/PlatformEngineering/terraform/ && ./scripts/init.sh'
alias tfplan='cd ~/Source/PlatformEngineering/terraform/ && ./scripts/plan.sh'
alias tfrefresh='cd ~/Source/PlatformEngineering/terraform/ && ./scripts/refresh.sh'
alias tfset='cd ~/Source/PlatformEngineering/terraform/ && source ./scripts/setup.sh'
alias tfauth='cd ~/Source/PlatformEngineering/terraform/ && source ./scripts/auth.sh'
alias azsub="~/Source/PlatformEngineering/utility/Azure/subscription-chooser.sh"

#tools
alias fd=fdfind

#security tools
alias harv='python3 ~/Source/theHarvester/theHarvester.py'
alias theHarvester='python3 ~/Source/theHarvester/theHarvester.py'
alias photon='python3 ~/Source/Photon/photon.py'

#knowledge base
alias kb="code ~/Documents/KB"

#eval "$(starship init bash)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

cheat() {
  # Ask cheat.sh website for details about a Linux command.
  curl -m 10 "http://cheat.sh/${*}" 
}

wifi(){
    nmcli dev wifi list
}

get_azure_ranges(){
    set -e
    INITIALURL="https://www.microsoft.com/en-in/download/confirmation.aspx?id=41653"
    OUT=$(curl -s "${INITIALURL}" | grep -Eo '"https://[^"]*PublicIPs[^"]*"'|head -n 1|cut -d '"' -f 2)
    curl -s -f "${OUT}"
}

wiki() {
    ag -i -A 0 -B 0 -W 120 -m 1 -a -f --nonumbers --silent "$1" --color-match "34;49" /home/dave/Documents/KB/Open-Money.wiki/
}

wiki-update() {
    workingdir=$(pwd)
    cd /home/dave/Documents/KB/Open-Money.wiki/
    git reset --hard HEAD > /dev/null 2>&1
    git pull --ff-only
    cd $workingdir
}

alias bettercap="sudo bettercap --caplet http-ui"

export PATH="$HOME/.apicheck_manager/bin:$PATH"
export PATH=$PATH:/usr/local/go/bin

DOTNET_CLI_TELEMETRY_OPTOUT=1

export PATH="/home/dave/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

export PKG_CONFIG_PATH="/usr/lib/x86_64-linux-gnu/pkgconfig/"

PATH="/home/dave/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/dave/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/dave/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/dave/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/dave/perl5"; export PERL_MM_OPT;
