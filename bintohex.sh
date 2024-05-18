#!/usr/bin/bash
j=$1
echo "obase=16; ibase=2; ${j^^}" | bc

