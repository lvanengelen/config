export PATH=$HOME/.local/bin:$PATH
export PAGER=less
export VISUAL=vim EDITOR=vim
export PYTHONPATH=$HOME/.local/lib/python2
export PS1="\u@\h:\W\$ "
export CVS_RSH=ssh
export HISTFILE=$HOME/.sh_history

if [ -z $SSH_AUTH_SOCK ]; then
    eval `ssh-agent` > /dev/null
fi

alias ls='ls -F'
