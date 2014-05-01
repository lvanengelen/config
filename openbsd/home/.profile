# $OpenBSD: dot.profile,v 1.4 2005/02/16 06:56:57 matthieu Exp $
#
# sh/ksh initialization

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/X11R6/bin
PATH=$PATH:/usr/local/bin:/usr/local/sbin:/usr/games
PATH=$PATH:/usr/local/jdk-1.7.0/bin:$HOME/.local/bin
export PATH

snapshots_path=ftp://ftp.bit.nl/pub/OpenBSD/snapshots
arch=`uname -p`
export SM_PATH=$snapshots_path/$arch
export PKG_PATH=$snapshots_path/packages/$arch

export LC_CTYPE=en_US.UTF-8
export PAGER=less
export VISUAL=vim EDITOR=vim
export PRINTER=rp
export PYTHONPATH=$HOME/.local/lib/python2
export PS1="\u@\h:\W\$ "

alias ls='ls -F'
