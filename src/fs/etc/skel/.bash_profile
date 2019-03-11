# ensure ~/.bash/env gets run first
. ~/.bash/env

# prevent it from being run later, since we need to use $BASH_ENV for non-login non-interactive shells.
# we don't export it, as we may have a non-login non-interactive shell as a child.
BASH_ENV=

# run ~/.bash/login
. ~/.bash/login

# run ~/.bash/interactive if this is an interactive shell.
if [ "$PS1" ]
then
    . ~/.bash/interactive
fi
