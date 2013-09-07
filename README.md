config
======

Configuration files for my various desktop/server systems.

home
====

    $ cp -r home/*
    $ # Rename OS dependent stuff
      find . -name '*.'`uname` | while read f; do echo ${f%.*}; done
