#!/usr/bin/env bash
# lib/fonts.sh
#
# Cross-platform font querying helpers.
# Pure functions. No logging, no exits.

fonts::list_linux() {
  fc-list : family file
}

fonts::list_macos() {
  system_profiler SPFontsDataType |
    awk -F: '
      /^[[:space:]]*Full Name:/ { name=$2; gsub(/^[[:space:]]+/, "", name) }
      /^[[:space:]]*Location:/  { file=$2; gsub(/^[[:space:]]+/, "", file);
                                   if (name && file) {
                                     printf "%s: %s\n", name, file
                                     name=""; file=""
                                   }
                                 }'
}

fonts::list_windows() {
    powershell.exe -NoProfile -Command - <<'POWERSHELL' 2>/dev/null
      Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" |
      Get-Member -MemberType NoteProperty |
      ForEach-Object {
        "$($_.Name): $((Get-ItemPropertyValue 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts' $_.Name))"
      }
POWERSHELL
}

fonts::list_raw() {
  if os::is_linux && guard::has_command fc-list; then
    fonts::list_linux
    return
  fi

  if os::is_macos && guard::has_command system_profiler; then
    fonts::list_macos
    return
  fi

  if os::is_windows && guard::has_command powershell.exe; then
    fonts::list_windows
    return
  fi

  return 1
}
