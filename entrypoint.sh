#!/bin/sh -l

result=`kubectl testkube $1 $2 $3`

status=$?
if [[ $status -eq 1 ]]; then
  exit 1
fi

result="${result//'%'/'%25'}"
result="${result//$'\n'/'%0A'}"
result="${result//$'\r'/'%0D'}"

echo "::set-output name=result::$result"
