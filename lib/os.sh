#!/usr/bin/env bash
# lib/os.sh
#
# Operating system and architecture detection helpers.
# Pure functions. No logging, no exits, no global state.

# ------------------------------------------------------------------------------
# OS detection
# ------------------------------------------------------------------------------

os::name() {
  uname -s 2>/dev/null | tr '[:upper:]' '[:lower:]'
}

os::kernel() {
  uname -r 2>/dev/null || true
}

# ------------------------------------------------------------------------------
# Architecture detection
# ------------------------------------------------------------------------------

os::arch_raw() {
  uname -m 2>/dev/null || true
}

os::arch() {
  case "$(os::arch_raw)" in
    x86_64)            printf "amd64\n" ;;
    aarch64 | arm64)   printf "arm64\n" ;;
    *)
      return 1
      ;;
  esac
}

# ------------------------------------------------------------------------------
# OS family checks
# ------------------------------------------------------------------------------

os::is_linux() {
  [[ "$(os::name)" == "linux" ]]
}

os::is_macos() {
  [[ "$(os::name)" == "darwin" ]]
}

os::is_windows() {
  case "$(os::name)" in
    cygwin* | mingw* | msys*) return 0 ;;
    *) return 1 ;;
  esac
}

os::is_wsl() {
  os::is_linux && grep -qi 'microsoft' /proc/version 2>/dev/null
}

# ------------------------------------------------------------------------------
# Linux distro helpers (soft, optional)
# ------------------------------------------------------------------------------

os::distro() {
  if [[ -f /etc/os-release ]]; then
    grep '^ID=' /etc/os-release | cut -d= -f2 | tr -d '"' || true
  elif os::is_macos; then
    printf "macos\n"
  fi
}

os::version() {
  if [[ -f /etc/os-release ]]; then
    grep '^VERSION_ID=' /etc/os-release | cut -d= -f2 | tr -d '"' || true
  elif os::is_macos; then
    sw_vers -productVersion 2>/dev/null || true
  fi
}

os::id_like() {
  if [[ -f /etc/os-release ]]; then
    grep '^ID_LIKE=' /etc/os-release | cut -d= -f2 | tr -d '"' || true
  elif os::is_macos; then
    printf "darwin\n"
  fi
}

# ------------------------------------------------------------------------------
# Capability checks
# ------------------------------------------------------------------------------

os::has_supported_arch() {
  os::arch >/dev/null 2>&1
}

os::has_supported_os() {
  os::name >/dev/null 2>&1
}
