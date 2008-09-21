#!/bin/sh

cd $(dirname $0)
find `pwd` -maxdepth 1 -name '.*' | grep -v 'git' | xargs -I{} ln -fs {} $HOME

exit 0
