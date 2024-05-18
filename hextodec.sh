#!/usr/bin/env bash

echo "ibase=16; ${1^^}" | bc
