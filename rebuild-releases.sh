#!/usr/bin/env bash

mkdir -p releases
tags=$(git tag)
for t in $tags
do
  echo "t: $t"
  git checkout tags/$t
  ./build.sh
  latest_tag=$(git describe --abbrev=0 --tags)
  $(pwd)
  cp -r output releases/$latest_tag
  cd releases
  rm current
  ln -s $latest_tag current
  cd ..
  # clean the build output
  rm -rf output
  git checkout master
done;
