#!/bin/bash
set -eu

for i in $( brew list );do
  echo $i ": " `brew deps --installed $i`
done
