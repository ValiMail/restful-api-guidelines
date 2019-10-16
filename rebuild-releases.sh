#!/usr/bin/env bash

mkdir -p releases
tags=$(git tag)
for t in $tags
do
  echo "Rebuilding Documentation based on Tag: $t"
  git checkout tags/$t
  ./build.sh
  cp -r output releases/$t
  # shell out to create the symbolic link
  (cd releases && rm current && ln -s $t current)
  git checkout master
  # clean the build output
  rm -rf output
done;
