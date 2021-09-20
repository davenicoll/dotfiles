# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

autoload zmv
alias zcp='zmv -C' zln='zmv -L'

# aws cli completion
# complete -C '/usr/local/bin/aws_completer' aws
# kubectl tab completion
# source <(kubectl completion zsh)

# Default ZSH prompt
#PROMPT="%n@%m %1~ %#"

# Minimal shell prompt because I use iTerm2 with this status bar: 
# "User name" "Host name" "Current directory" "Git state" "Spring"
# Also go to Advanced ... and check "Perfer tight packing to stable position"
PROMPT="✨ "