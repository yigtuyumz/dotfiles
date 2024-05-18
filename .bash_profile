#!/usr/bin/env bash

#shellcheck disable=SC1090

#
# ~/.bash_profile
#


alias lall='ls -lac'
alias ldir='ls -lcd */'
alias valgrind='valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes'
alias transet='trans en:tr'
alias transte='trans tr:en'
alias transed='trans en:de'
alias transde='trans de:en'
alias transtd='trans tr:de'
alias transdt='trans de:tr'
alias py='python3.11'
alias d='docker'

. "$HOME/.cargo/env"
