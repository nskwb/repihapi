#!/bin/sh
set -e

rm -f /myapp/tmp/pids/server.pid

bundle exec rails s -p ${PORT:-3000} -b 0.0.0.0
