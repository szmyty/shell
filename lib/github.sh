#!/usr/bin/env bash
# lib/github.sh
#
# GitHub API helpers.
# Pure functions. No logging, no exits.

github::latest_release_json() {
  local repo="$1"
  curl --silent --show-error --location \
    "https://api.github.com/repos/${repo}/releases/latest"
}

github::latest_tag() {
  jq --raw-output '.tag_name'
}

github::tarball_url() {
  jq --raw-output '.tarball_url'
}

github::published_at() {
  jq --raw-output '.published_at'
}

github::commit_sha_for_tag() {
  local repo="$1"
  local tag="$2"
  git ls-remote "https://github.com/${repo}.git" "refs/tags/${tag}" | cut -f1
}
