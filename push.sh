#!/bin/bash
echo "push start!"
git status
git add .
if [[ $1 ]]; then
	git commit -m $1
else
	time=$(date "+%Y-%m-%d %H:%M:%S")
	git commit -m "${time}"
	echo "commit message: ${time}"
fi
git push origin 1.5.0
echo "push end!"