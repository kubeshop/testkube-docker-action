#!/bin/sh -l

result=`testkube $1 $2 $3`
echo "::set-output name=result::$result"
