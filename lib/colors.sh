#!/usr/bin/env bash
# lib/colors.sh
#
# ANSI color helpers.
# All functions return escape sequences and never print directly.
# Safe to source anywhere.

# ------------------------------------------------------------------------------
# Internal: check if colors should be enabled
# ------------------------------------------------------------------------------

color::__enabled() {
  [[ -t 1 ]] && [[ -n "${TERM:-}" ]] && [[ "${NO_COLOR:-0}" != "1" ]]
}

# ------------------------------------------------------------------------------
# Reset
# ------------------------------------------------------------------------------

color::reset() {
  color::__enabled && printf '\033[0m' || true
}

# ------------------------------------------------------------------------------
# Standard colors
# ------------------------------------------------------------------------------

color::black()   { color::__enabled && printf '\033[30m' || true; }
color::red()     { color::__enabled && printf '\033[31m' || true; }
color::green()   { color::__enabled && printf '\033[32m' || true; }
color::yellow()  { color::__enabled && printf '\033[33m' || true; }
color::blue()    { color::__enabled && printf '\033[34m' || true; }
color::magenta() { color::__enabled && printf '\033[35m' || true; }
color::cyan()    { color::__enabled && printf '\033[36m' || true; }
color::white()   { color::__enabled && printf '\033[37m' || true; }
color::gray()    { color::__enabled && printf '\033[90m' || true; }

# ------------------------------------------------------------------------------
# Styles (optional, but useful)
# ------------------------------------------------------------------------------

color::bold()      { color::__enabled && printf '\033[1m' || true; }
color::dim()       { color::__enabled && printf '\033[2m' || true; }
color::underline() { color::__enabled && printf '\033[4m' || true; }
