#!/bin/sh
set -e

if [[ -e "/openrc.sh" ]]; then
    source "/openrc.sh"
else
    echo "### Error: Cannot source file"
fi

exec "$@"
