#!/usr/bin/env bash

mkdir -p releases
tags=$(git tag)
for t in $tags
do
  echo "t: $t"
  git checkout tags/$t
  ./build.sh
  # clean the build output
  rm -rf output
  latest_tag=$(git describe --abbrev=0 --tags)
  cp -r output releases/$latest_tag
  rm releases/current
  cd releases
  ln -s $latest_tag current
  git checkout master
done;
