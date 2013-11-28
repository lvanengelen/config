export CVS_RSH=ssh
export LANG=en_US.utf-8
export PAGER=less
export PATH=$HOME/.local/bin:$PATH
export PS1="\u@\h:\W\$ "
export PYTHONPATH=$HOME/.local/lib/python2

VISUAL=${VISUAL:-vim}
EDITOR=${EDITOR:-vim}
export EDITOR VISUAL

if [ -d /usr/bin/vendor_perl ]; then
    PATH=/usr/bin/vendor_perl:$PATH
fi

if [ -z "$BASH" ]; then
    export HISTFILE=$HOME/.sh_history
fi

if [ -z $SSH_AUTH_SOCK ]; then
    eval `ssh-agent` > /dev/null
fi

alias ls='ls -F'
