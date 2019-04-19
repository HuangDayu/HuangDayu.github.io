#!/bin/bash
a="s/"+$2+"/"+$3+"/g"
sed -i $a `grep $2 -rl $1`
echo "update success!"