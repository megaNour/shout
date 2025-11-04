#!/bin/sh

i=0
while [ "$i" -lt 256 ]; do
  printf '%s ' "[38;5;${i}m$i${_res}"
  i=$((i + 1))
done
printf "%s\n" "$_res"
