#!/bin/bash
git checkout --orphan blog_new
git branch -D 1.5.0
git checkout --orphan 1.5.0
git add .
time=$(date "+%Y-%m-%d %H:%M:%S")
git commit -m "${time}"
git push -f origin 1.5.0
echo "Clear success!"