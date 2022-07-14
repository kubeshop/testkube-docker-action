#!/bin/sh -l

command="kubectl testkube $1 $2 $3"
result=$(eval "$command")
echo "::set-output name=result::$result"
