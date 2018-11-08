#!/bin/bash
set -e

if [[ -n "$TZ" ]]; then
  cp /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
fi

exec "$@"
