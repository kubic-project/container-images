#!/bin/bash

if [ -n "$VELUM_DB_PASSWORD_FILE" ] && [ -f "$VELUM_DB_PASSWORD_FILE" ]; then
  export VELUM_DB_PASSWORD=`cat "$VELUM_DB_PASSWORD_FILE"`
fi

if [ -n "$VELUM_SALT_PASSWORD_FILE" ] && [ -f "$VELUM_SALT_PASSWORD_FILE" ]; then
  export VELUM_SALT_PASSWORD=`cat "$VELUM_SALT_PASSWORD_FILE"`
fi

exec "$@"
