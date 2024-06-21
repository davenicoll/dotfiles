wiki() {
    ag -i -A 0 -B 0 -W 120 -m 1 -a -f --nonumbers --silent "$1" --color-match "34;49" /Users/dave/Documents/slalom-kb
}

cheat() {
    curl -m 10 "http://cheat.sh/${*}"
}

source "$HOME/.go/env"

# Added by OrbStack: command-line tools and integration
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

# BitWarden CLI session key
BW_SESSION="A9eZEfHLE8w2Y/NSY1+7GA455SiW6BDYZj29Iebziuua1XhY/pfalglpqYMsm2vyFrXN6VFttQj0E3te+JZldQ=="

alias azsub="$HOME/Source/davenicoll/azure-subscription-chooser/subscription-chooser.sh"

eval "$(pyenv init --path)"

export PATH=~/.npm-global/bin:$PATH
export PATH="$PATH:/Users/dave/.gem/ruby/2.6.0/bin"
export PAGER='less -F -S -R -M -i'
export MANPAGER='less -R -M -i +Gg'
export EDITOR="/usr/bin/nano"
export KUBE_EDITOR="code -w"
export AWS_PAGER=""
export DOCKER_HOST="unix://${HOME}/.colima/default/docker.sock"
export PICO_SDK_PATH="/Users/dave/Source/pico-sdk"
export TF_CLI_ARGS_apply="-auto-approve"
export ATMOS_CLI_CONFIG_PATH="./config"
export ATMOS_BASE_PATH="./"
