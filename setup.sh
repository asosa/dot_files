#!/bin/bash

exec_path=$(dirname $0)
filenames=$(find $exec_path -maxdepth 1 -name '.*' | grep -v 'bzr')

for filename in ${filenames[@]}; do
  ln -fs $filename $HOME
done
