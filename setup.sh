#!/bin/sh

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

ln -sf ${BASEDIR}/gitconfig ~/.gitconfig
