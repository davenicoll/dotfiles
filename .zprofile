export PAGER='less -F -S -R -M -i'
export MANPAGER='less -R -M -i +Gg'
export EDITOR="/usr/bin/nano"
export KUBE_EDITOR="code -w"
export AWS_PAGER=""

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[ -d "$PYENV_ROOT/bin" ] && export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv >/dev/null 2>&1; then
    eval "$(pyenv init --path)"
fi
