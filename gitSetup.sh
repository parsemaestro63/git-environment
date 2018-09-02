#!/bin/bash

function setConfig {
    if [[ "$PARAM" != "" ]]; then
        if [[ $($GIT_PARAM) != "" ]]; then
            echo "There is already a global value configured," \"$($GIT_PARAM)\" ". Do you want to override this (y/n)?"
            read OVERRIDE

            case "$OVERRIDE" in
                y)
                    $($GIT_PARAM_SET "$PARAM")
                ;;
                n)
                ;;
                ?)
                    echo "An unknown argument was provided: Exiting."
                    exit 2
                ;;
            esac
        else
            $($GIT_PARAM_SET "$PARAM")
        fi
    fi
}

# Configure globals
echo "Provide a global user name (if already set, just hit [Enter]):"
read PARAM

GIT_PARAM="git config --global user.name"
GIT_PARAM_SET="git config --global --replace-all user.name"

setConfig

echo "Provide a global email (if already set, just hit [Enter]):"
read PARAM

GIT_PARAM="git config --global user.email"
GIT_PARAM_SET="git config --global --replace-all user.email"

setConfig

# Setup auto-rebase
git config --global pull.rebase true
git config --global branch.autosetuprebase always

#set up local -> remote branch matching
git config --global push.default matching

if [[ $1 == --create-alias ]]; then
    ./createAliases.sh
fi

echo "Git configuration is completed."