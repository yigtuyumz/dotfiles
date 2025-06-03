#!/usr/bin/env bash
#shellcheck disable=SC1090

# [[ -f ~/.bashrc ]] && . ~/.bashrc

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

play() {
  if [ -f /home/wagabond12/i3scripts/play.sh ]; then
    /home/wagabond12/i3scripts/play.sh "${1}"
  else
    echo "/home/wagabond12/i3scripts/play.sh not found."
  fi
}

konvert() {
  "$(which bash)" /home/wagabond12/konvert.sh "$@"
}

# copies contents of piped lvalue. discards trailing newlines.
copy() {
  (cat | awk 'ORS=""; {print}') | xclip -selection clipboard
}

alias code='/home/wagabond12/Downloads/VSCode-linux-x64/bin/code'
alias tt='tt -n 15'

export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

export MAIL_42="yuyumaz@student.42kocaeli.com.tr"
export USER_42="yuyumaz"

# indent disable backup '~' files
declare -x VERSION_CONTROL=none
