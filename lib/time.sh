#!/usr/bin/env bash
# lib/time.sh
#
# Time helpers.

time::epoch() {
  date -u +%s
}

time::epoch_ms() {
  printf '%(%s)T%03d\n' -1 0
}

time::timestamp() {
  date '+%Y-%m-%d %H:%M:%S'
}

time::utc_timestamp() {
  date -u '+%Y-%m-%d %H:%M:%S'
}

time::iso8601() {
  date -u '+%Y-%m-%dT%H:%M:%SZ'
}
