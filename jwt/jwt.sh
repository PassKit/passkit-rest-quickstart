#!/bin/bash

# $1 key
# $2 secret
# $3 expiry (if blank assume 60 seconds)

help="Usage: jwt.sh [apiKey] [apiSecret] [expiry seconds (optional)]"
if [[ -z $1 || -z $2 ]]; then
  echo $help
  exit 0
fi

# create header
header=$(echo -n '{"alg":"HS256","typ":"JWT"}' | openssl base64 -e -A | sed s/\+/-/g | sed -E s/=+$//g | sed 's/\//_/g')

# set iat as now and exp default to iat+60 if no expiry is set
iat=$(date +%s)
life=60
if [[ ! -z $3 ]]; then
  life=$3
fi
exp=$(($iat + $life))

# encode claims
claims=$(echo -n "{\"iat\": $iat,\"exp\": $exp,\"uid\": \"$1\"}" | openssl base64 -e -A | sed s/\+/-/g | sed -E s/=+$//g | sed 's/\//_/g')

# sign header and claims
signature=$(echo -n $header.$claims | openssl dgst -sha256 -hmac $2 -binary | openssl base64 -e -A | sed s/\+/-/g | sed -E s/=+$//g | sed 's/\//_/g')

# output the JWT
echo "$header.$claims.$signature"