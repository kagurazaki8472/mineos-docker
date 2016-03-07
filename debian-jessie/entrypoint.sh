#!/bin/bash
set -eo pipefail

sh /usr/games/minecraft/generate-sslcert.sh

if [ -z "$MC_PASSWORD" ]; then
  echo >&2 'You need to specify MC_PASSWORD'
  exit 1
else
  echo "mc:$MC_PASSWORD" | chpasswd
fi

exec "$@"
