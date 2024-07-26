#!/usr/bin/env bash

#shellcheck disable=SC1090

#
# ~/.bash_profile
#


alias lall='ls -lacv'
alias ldir='ls -lcdv */'
alias valgrind='valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes'
alias transet='trans en:tr'
alias transte='trans tr:en'
alias transed='trans en:de'
alias transde='trans de:en'
alias transtd='trans tr:de'
alias transdt='trans de:tr'
alias py='python3.12'
alias d='docker'
alias :wq='exit'
alias :q=':wq'
alias code='/home/wagabond12/Downloads/VSCode-linux-x64/bin/code'

play() {
  /home/wagabond12/i3scripts/play.sh "${1}"
}

