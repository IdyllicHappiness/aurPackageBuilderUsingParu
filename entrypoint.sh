#! /usr/bin/env bash

set -ex

ls -lahR /github

cd /home/builder
mkdir workdir
cd workdir

# cp -rfv "$GITHUB_WORKSPACE"/checkout/.git ./
cp -fv "$GITHUB_WORKSPACE"/checkout/PKGBUILD ./

# paru -G "$INPUT_PACKAGE"

# cd "$INPUT_PACKAGE" || exit 1

tempOutputDir=$(mktemp -d)

PKGDEST="$tempOutputDir" paru -B --skipreview --noconfirm .

cp -a "$tempOutputDir"/* "$GITHUB_WORKSPACE"/output
