config
======

Configuration files for my various desktop/server systems.

home
====

    $ cp -r home/*
    $ # rename os dependent stuff
    $ find . -name '*.'`uname` | while read f; do mv $f ${f%.*}; done
    $ # install vim packages
    $ vim -c BundleInstall
