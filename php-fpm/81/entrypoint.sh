#!/bin/sh
supervisord -n -c /etc/supervisord.conf

exec "$@"