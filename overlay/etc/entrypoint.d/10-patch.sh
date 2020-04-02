#!/usr/bin/env bash

# Configuration
readonly PATCH_DIR=/etc/patch.d
readonly BACKUP_SUFFIX="~"


apply_patch_once()
{
  local patch_file="${1}"
  local file=$(lsdiff --strip=1 ${patch_file})
  if [[ -e "${file}${BACKUP_SUFFIX}" ]]; then
    patch --backup --suffix=${BACKUP_SUFFIX} -p1 < ${patch_file}
  fi
}

if [[ -e ${PATCH_DIR} ]]; then
  for patch_file in $(find ${PATCH_DIR} -type f -iname '*.patch' |sort); do
    apply_patch_once ${patch_file}
  done
fi
