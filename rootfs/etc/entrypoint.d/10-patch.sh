#!/usr/bin/env bash

# Configuration
readonly PATCH_DIR=/etc/patch.d
readonly BACKUP_SUFFIX="~"


function is_already_patched() {
    local patch_=$1
    local file_=$(lsdiff --strip=1 $1)
    [ -e "${file_}${BACKUP_SUFFIX}" ]
    return 
}

function apply_patch() {
    local patch_=$1
    patch --backup --suffix=${BACKUP_SUFFIX} -p1 < ${patch_}
    return
}

if [ -e ${PATCH_DIR} ]; then
    for PATCH in $(find ${PATCH_DIR} -type f -iname '*.patch'); do
        is_already_patched ${PATCH} || \
            apply_patch ${PATCH}
    done
fi
