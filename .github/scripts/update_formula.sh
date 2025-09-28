#!/bin/bash
set -e

# Get the latest tag from the workflow context or git
tag="$1"
if [ -z "$tag" ]; then
  tag=$(git describe --tags --abbrev=0)
fi

# Download the tarball
url="https://github.com/malhotra-rishabh/boogiewoogie/archive/refs/tags/${tag}.tar.gz"
curl -L -o boogiewoogie-${tag}.tar.gz "$url"

# Calculate sha256
sha256=$(shasum -a 256 boogiewoogie-${tag}.tar.gz | awk '{print $1}')

# Update boogiewoogie.rb
sed -i.bak \
  -e "s|url \"https://github.com/malhotra-rishabh/boogiewoogie/archive/refs/tags/v[0-9.]*.tar.gz\"|url \"$url\"|" \
  -e "s|sha256 \"[a-f0-9]*\"|sha256 \"$sha256\"|" \
  -e "s|version \"[0-9.]*\"|version \"${tag#v}\"|" \
  boogiewoogie.rb

rm boogiewoogie-${tag}.tar.gz

# Show the updated formula
grep -E 'url |sha256 |version ' boogiewoogie.rb
