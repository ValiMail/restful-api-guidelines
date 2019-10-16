#!/usr/bin/env bash

mkdir -p releases
tags=$(git tag)
for t in $tags
do
  echo "t: $t"
  git checkout tags/$t
  ./build.sh
  latest_tag=$(git describe --abbrev=0 --tags)
  cp -r output releases/$latest_tag
  # shell out to create the symbolic link
  (cd releases && rm current && ln -s $latest_tag current)
  # clean the build output
  rm -rf output
  git checkout master
done;
