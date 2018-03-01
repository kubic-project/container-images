#!/bin/bash

NOFILE_LIMIT=${NOFILE_LIMIT:-20000}

if [ -z "$SALTAPI_PASSWORD" ] && [ -z "$SALTAPI_PASSWORD_FILE" ]; then
  echo >&2 "You need to provide SALTAPI_PASSWORD or SALTAPI_PASSWORD_FILE"
  exit 1
fi

if [ -n "$SALTAPI_PASSWORD_FILE" ] && [ -f "$SALTAPI_PASSWORD_FILE" ]; then
  SALTAPI_PASSWORD=`cat "$SALTAPI_PASSWORD_FILE"`
fi

echo "saltapi:$SALTAPI_PASSWORD" | chpasswd

# Set lower number of max open fd per process. Required to fix bsc#1074836
ulimit -n ${NOFILE_LIMIT}

exec "$@"
