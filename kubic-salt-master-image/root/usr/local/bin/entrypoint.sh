#!/bin/bash

if [ -z "$SALTAPI_PASSWORD" ] && [ -z "$SALTAPI_PASSWORD_FILE" ]; then
  echo >&2 "You need to provide SALTAPI_PASSWORD or SALTAPI_PASSWORD_FILE"
  exit 1
fi

if [ -n "$SALTAPI_PASSWORD_FILE" ] && [ -f "$SALTAPI_PASSWORD_FILE" ]; then
  SALTAPI_PASSWORD=`cat "$SALTAPI_PASSWORD_FILE"`
fi

echo "saltapi:$SALTAPI_PASSWORD" | chpasswd

exec "$@"
