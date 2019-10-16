#!/usr/bin/env bash


tags=$(git tag)
for t in $tags
do
  echo "t: $t"
  git checkout tags/$t
  ./build.sh
  latest_tag=$(git describe --abbrev=0 --tags)
  cp -r output releases/$latest_tag
  rm releases/current
  cd releases
  ln -s $latest_tag current
  git checkout master
done;
