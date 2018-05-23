#!/bin/bash
set -e
set -o pipefail

_here=`dirname $(realpath $0)`
. ${_here}/apt-download

[ -z "${LOADED_APT_DOWNLOAD}" ] && (echo "failed to load apt-download"; exit 1)

BASE_PATH="${_here}/neovim"

UBUNTU_VERSIONS=("xenial")
UBUNTU_PATH="${BASE_PATH}"

mkdir -p $UBUNTU_PATH

if [[ ! -z ${DRY_RUN:-} ]]; then
	export APT_DRY_RUN=1
fi

base_url="http://ppa.launchpad.net/neovim-ppa/stable/ubuntu"
for version in ${UBUNTU_VERSIONS[@]}; do
	apt-download-binary ${base_url} "$version" "main" "amd64" "${UBUNTU_PATH}" || true
	apt-download-binary ${base_url} "$version" "main" "i386" "${UBUNTU_PATH}" || true
done

# vim: ts=4 sts=4 sw=4
