#!/bin/sh -l

command="$1"
resource="$2"
namespace="$3"
apikey="$4"
apiuri="$5"
parameters="$6"
stdin="$7"

cmdline="kubectl testkube ${command} ${resource}"
if [[ ! -z "$namespace" ]]; then
  cmdline="${cmdline} --namespace ${namespace}"
fi

if [[ ! -z "$apikey" ]]; then
  mkdir .testkube
  echo "{\"oauth2Data\":{\"enabled\":true,\"token\":{\"access_token\":\"$apikey\",\"token_type\":\"bearer\",\"expiry\":\"0001-01-01T00:00:00Z\"}" > .testkube/config.json
fi

if [[ ! -z "$apiuri" ]]; then
  cmdline="${cmdline} --api-uri ${apiuri} --client direct"
fi

if [[ ! -z "$parameters" ]]; then
  cmdline="${cmdline} ${parameters}"
fi

if [[ ! -z "$stdin" ]]; then
  $(echo $stdin | $cmdline)
  #result="$(eval "echo "$stdin" | $cmdline")"
else
  $($cmdline)
  #result="$(eval "$cmdline")"
fi

status=$?
if [[ $status -eq 1 ]]; then
  exit 1
fi

result="${result//'%'/'%25'}"
result="${result//$'\n'/'%0A'}"
result="${result//$'\r'/'%0D'}"

echo "result=$result" >> $GITHUB_OUTPUT
