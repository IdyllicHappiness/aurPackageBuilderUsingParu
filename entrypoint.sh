#! /usr/bin/env bash

set -ex

cd /home/builder

ls -lahR /github

paru -G "$INPUT_PACKAGE"

cd "$INPUT_PACKAGE" || exit 1

tempOutputDir=$(mktemp -d)

PKGDEST="$tempOutputDir" paru -B --noconfirm .

cp -a "$tempOutputDir"/* /github/workspace
