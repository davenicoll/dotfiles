#!/bin/bash

if ! command -v pyenv &> /dev/null; then
    curl https://pyenv.run | bash
    source ~/.bashrc
else
    echo "pyenv already installed"
fi

if ! command -v python &> /dev/null; then
    #latest_python_version=$(pyenv install --list | grep --extended-regexp "^\s*[0-9][0-9.]*[0-9]\s*$" | tail -1)
    # at the time of creation, 3.10.0 is so fked up it doesn't build
    # reverting to the last stable version 3.9.7
    pyenv install 3.9.7 # $latest_python_version
    pyenv global 3.9.7 # $latest_python_version
else
    echo "python already installed"
    pyenv versions
fi