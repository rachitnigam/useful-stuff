#!/bin/bash

# Recursively remove the unused dependencies of a given package
# Acts as the inverse of recursive installation done brew

`brew remove $1`
set -eu

X=""
COUNT=1
while [ $COUNT != 0 ]; do
  COUNT=0

  for i in $( brew deps --installed $1 );do
    X=`brew uses --installed $i`
  
    # Comparsion equivalent to checking that
    # the current package is not a dependency of
    # any other packages
    if [ "$X" == "" ]; then 
      echo "Removing : " $i 
      let COUNT=COUNT+1 
      brew remove $i
    fi
  done
done

set +eu

echo "Removal Complete"
unset X Y COUNT
