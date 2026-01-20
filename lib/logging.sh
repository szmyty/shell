#!/usr/bin/env bash
# lib/logging.sh
#
# Structured logging helpers.
#
# Soft-depends on:
#   - time::timestamp
#   - terminal::is_interactive_term
#   - color::*
#
# All functions return status codes and never exit.

log::__print() {
  local level="$1" emoji="$2" color="$3"
  shift 3
  local message="$*"

  local timestamp label reset

  # Timestamp (optional)
  if command -v time::timestamp >/dev/null; then
    timestamp="$(time::timestamp)"
  else
    timestamp=""
  fi

  # Uppercase label
  label="$(printf '%s' "${level}" | tr '[:lower:]' '[:upper:]')"

  # Color reset (optional)
  if command -v color::reset >/dev/null; then
    reset="$(color::reset)"
  else
    reset=""
  fi

  # Interactive terminal formatting
  if command -v terminal::is_interactive_term >/dev/null &&
     terminal::is_interactive_term; then
    printf '%s %b%-10s%b %s\n' \
      "${timestamp}" \
      "${color:-}" "${emoji} ${label}:" "${reset}" \
      "${message}" >&2
  else
    printf '%s %-10s %s\n' \
      "${timestamp}" "${emoji} ${label}:" \
      "${message}" >&2
  fi
}

log::info() {
  log::__print info "🔹" "$(command -v color::blue >/dev/null && color::blue)" "$@"
}

log::warn() {
  log::__print warn "⚠️" "$(command -v color::yellow >/dev/null && color::yellow)" "$@"
}

log::error() {
  log::__print error "❌" "$(command -v color::red >/dev/null && color::red)" "$@"
}

log::success() {
  log::__print success "✅" "$(command -v color::green >/dev/null && color::green)" "$@"
}

log::debug() {
  [[ "${UBI_DEBUG:-0}" == "1" ]] || return 0
  log::__print debug "🐞" "$(command -v color::gray >/dev/null && color::gray)" "$@"
}
