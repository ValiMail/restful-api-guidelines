#!/usr/bin/env bash


tags=$(git tag)
for t in $tags
do
  echo "t: $t"
  git checkout tags/$t
done;
exit 0
echo "tag_count: $tag_count"

release_count=$(find releases -mindepth 1 -maxdepth 1 -type d | wc -l)
echo "release_count: $release_count"

if [ "$tag_count" -gt "$release_count" ] 
  then
	echo "releasing...."
    ./build.sh
    latest_tag=$(git describe --abbrev=0 --tags)
	cp -r docs releases/$latest_tag
	rm releases/current
	cd releases
	ln -s $latest_tag current
else
	echo "The number of git tags matches the number of documentation releases"
fi
