#!/bin/bash
git status
git checkout --orphan blog
git add .
if [[ $1 ]]; then
	git commit -m $1
else
	time=$(date "+%Y-%m-%d %H:%M:%S")
	git commit -am "${time}"
	echo "commit message: ${time}"
fi
git branch -D master
git branch -m master
git push -f origin master
echo "reset commit end!"