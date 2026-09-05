#!/usr/bin/env bash

set -euo pipefail

desktop_file=/usr/share/applications/calamares.desktop

if [[ -f "${desktop_file}" ]]; then
    sed -i '/^NoDisplay=/d' "${desktop_file}"
    printf '\nNoDisplay=true\n' >>"${desktop_file}"
fi
