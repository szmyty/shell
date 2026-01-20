#!/usr/bin/env bash
#
# shell.sh
#
# Optional shell helpers.
# Pure functions, safe to source explicitly.

# Resolve the directory this file lives in (works when sourced)
_SHELL_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source all library files
for _file in "${_SHELL_ROOT}"/lib/*.sh; do
  # shellcheck source=/dev/null
  source "$_file"
done

unset _file
unset _SHELL_ROOT
