#!/usr/bin/env bash
# last positional parameter
# echo ${!#}

hexdec() {
  echo "ibase=16; ${1^^}" | bc
}

hexbin() {
  local j
  j=${1}
  echo "obase=2; ibase=16; ${j^^}" | bc
}

dechex() {
  echo "obase=16; ${1}" | bc
}

decbin() {
  echo "obase=2; ${1}" | bc
}

binhex() {
  local j
  j=${1}
  echo "obase=16; ibase=2; ${j^^}" | bc
}

bindec() {
  echo "ibase=2; ${1}" | bc
}

usage() {
  echo "Usage: $0 -[fromBase required] -[toBase required]  -[numericalValue required]"
  echo "[numericalValue]"
  echo "  a valid number expression"
  echo "[fromBase], [toBase]"
  echo "  In order to convert a number to another base, two different bases are required."
  echo "  If the two bases entered are the same, the program will not work."
  echo "  Available options for the base:"
  echo "    -h        Base of Hexadecimal."
  echo "    -d        Base of Decimal."
  echo "    -b        Base of Binary."
  exit 1
}

OPTSTRING="hdb"
OPTCOUNT=0
OPS=()
REGEX="^[0-9]+$"

while getopts "${OPTSTRING}" opt 2>/dev/null && [ "${OPTCOUNT}" -lt 3 ]; do
  case ${opt} in
    h)
      OPS[OPTCOUNT]="hex"
      if [ "${OPTCOUNT}" -eq 0 ]; then
        REGEX="^[0-9A-Fa-f]+$"
      fi
      ;;
    d)
      OPS[OPTCOUNT]="dec"
      ;;
    b)
      OPS[OPTCOUNT]="bin"
      ;;
    *)
      usage
      ;;
  esac
  ((OPTCOUNT++))
  if [ "${OPTCOUNT}" -gt 2 ]; then
    usage
  fi
done

if [[ ${!#} =~ $REGEX ]] 2>/dev/null; then
  for i in "${OPS[@]}"; do
    CALLFUNCTION+="${i}"
  done
  # skip first positional parameter, which is option string
  shift 1
  for arg in "$@"; do
    "${CALLFUNCTION}" "${arg}" 2>/dev/null || usage
  done
else
  usage
fi

