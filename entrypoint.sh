#!/bin/sh -l

result=`kubectl testkube $1 $2 $3`
result="${result//'%'/'%25'}"
result="${result//$'\n'/'%0A'}"
result="${result//$'\r'/'%0D'}"

echo "::set-output name=result::$result"
