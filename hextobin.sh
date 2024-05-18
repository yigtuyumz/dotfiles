#!/usr/bin/bash
j=$1
echo "obase=2; ibase=16; ${j^^}" | bc
