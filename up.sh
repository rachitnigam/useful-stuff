#!/bin/bash

#Script to add all files in a repository and commit them with a given message

X="$1"

git add -A
git commit -m ${X:="Updated repository"}
git push
