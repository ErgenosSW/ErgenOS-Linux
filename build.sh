#!/usr/bin/env bash

set -euo pipefail

project_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
profile_dir="${project_root}/ergenos"
repo_dir="${project_root}/repo"
output_dir="${ERGENOS_OUTPUT_DIR:-${project_root}/out}"
work_dir="${ERGENOS_WORK_DIR:-/var/tmp/ergenos-work-${USER}-$$}"
rebuild_packages=false

usage() {
    cat <<'EOF'
Usage: ./build.sh [--rebuild-packages]

Environment variables:
  ERGENOS_OUTPUT_DIR  ISO output directory (default: ./out)
  ERGENOS_WORK_DIR    Archiso work directory (default: unique /var/tmp path)
EOF
}

while (($#)); do
    case "$1" in
        --rebuild-packages)
            rebuild_packages=true
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            printf 'Unknown option: %s\n' "$1" >&2
            usage >&2
            exit 2
            ;;
    esac
    shift
done

for command in makepkg repo-add mkarchiso pacman-conf sudo; do
    if ! command -v "${command}" >/dev/null; then
        printf 'Missing required command: %s\n' "${command}" >&2
        exit 1
    fi
done

package_dirs=(
    packages/calamares
    packages/gnome-shell-extension-blur-my-shell
    packages/gnome-shell-extension-dash-to-dock
    packages/gnome-shell-extension-gtk4-desktop-icons-ng
)

mkdir -p "${repo_dir}" "${output_dir}"

for relative_dir in "${package_dirs[@]}"; do
    package_dir="${project_root}/${relative_dir}"
    mapfile -t package_files < <(
        cd "${package_dir}"
        makepkg --packagelist | grep -v -- '-debug-'
    )

    needs_build="${rebuild_packages}"
    for package_file in "${package_files[@]}"; do
        if [[ ! -f "${package_file}" ]]; then
            needs_build=true
        fi
    done

    if [[ "${needs_build}" == true ]]; then
        printf 'Building %s\n' "${relative_dir}"
        (cd "${package_dir}" && makepkg -s --needed --noconfirm)
    else
        printf 'Reusing built package from %s\n' "${relative_dir}"
    fi

    for package_file in "${package_files[@]}"; do
        cp -f -- "${package_file}" "${repo_dir}/"
    done
done

mapfile -t repo_packages < <(find "${repo_dir}" -maxdepth 1 -type f -name '*.pkg.tar.*' ! -name '*-debug-*' -print | sort)
if ((${#repo_packages[@]} == 0)); then
    printf 'No packages found for the local repository.\n' >&2
    exit 1
fi
repo-add -R "${repo_dir}/ergenos.db.tar.zst" "${repo_packages[@]}"

pacman_config="$(mktemp --tmpdir ergenos-pacman.XXXXXX.conf)"
cleanup() {
    rm -f -- "${pacman_config}"
}
trap cleanup EXIT

sed "s|^Server = file:///path/to/ErgenOS-Linux/repo$|Server = file://${repo_dir}|" \
    "${profile_dir}/pacman.conf" > "${pacman_config}"

if ! grep -Fxq "Server = file://${repo_dir}" "${pacman_config}"; then
    printf 'Failed to configure the local ErgenOS repository.\n' >&2
    exit 1
fi

printf 'Building ErgenOS %s\n' "$(<"${project_root}/VERSION")"
printf 'Work directory: %s\n' "${work_dir}"
printf 'Output directory: %s\n' "${output_dir}"

sudo mkarchiso -v -r \
    -C "${pacman_config}" \
    -w "${work_dir}" \
    -o "${output_dir}" \
    "${profile_dir}"
