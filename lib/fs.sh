#!/usr/bin/env bash
# lib/fs.sh
#
# Filesystem inspection helpers.
# Pure functions. No logging, no exits.

# ------------------------------------------------------------------------------
# fs::is_executable
#
# Returns 0 if the file has the executable bit set.
# ------------------------------------------------------------------------------

fs::is_executable() {
  [[ -x "$1" ]]
}

# ------------------------------------------------------------------------------
# fs::has_shebang
#
# Returns 0 if the file starts with a shebang (#!).
# ------------------------------------------------------------------------------

fs::has_shebang() {
  [[ -f "$1" ]] && head -n 1 "$1" | grep -qE '^#!'
}
