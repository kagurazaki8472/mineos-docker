#!/bin/bash
set -eo pipefail

if [ -z "$USER_PASSWORD" ]; then
  echo >&2 'You need to specify USER_PASSWORD'
  exit 1
fi

if [ "$USER_NAME" ]; then
  # username specifically provided, will overwrite 'mc'
  if [[ "$USER_NAME" =~ [^a-zA-Z0-9] ]]; then
    echo >&2 'USER_NAME must contain only alphanumerics [a-zA-Z0-9]'
    exit 1
  fi
else
  echo >&2 'USER_NAME not provided; defaulting to "mc"'
  USER_NAME=mc
fi

useradd -Ums /bin/false $USER_NAME
echo "$USER_NAME:$USER_PASSWORD" | chpasswd
echo >&2 "Created user: $USER_NAME"

echo >&2 "Generating Self-Signed SSL..."
sh /usr/games/minecraft/generate-sslcert.sh

exec "$@"
