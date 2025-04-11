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

if [[ -n "$INPUT_PRE_PKGS" ]]; then
    # shellcheck disable=SC2086
    paru -S --noconfirm $INPUT_PRE_PKGS
fi

tempOutputDir=$(mktemp -d)

PKGDEST="$tempOutputDir" paru -B --skipreview --noconfirm .

mkdir "$GITHUB_WORKSPACE"/output
cp -a "$tempOutputDir"/* "$GITHUB_WORKSPACE"/output
