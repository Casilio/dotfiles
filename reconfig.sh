#!/bin/bash

mkdir -p ~/bin
ln -s `pwd`/tx ~/bin
ln -s `pwd`/.tmux.conf ~/

mkdir -p ~/.config/nvim/
ln -s `pwd`/init.vim ~/.config/nvim/
