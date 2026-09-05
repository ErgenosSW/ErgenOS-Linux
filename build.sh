#!/usr/bin/env bash

set -euo pipefail

project_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
profile_dir="${project_root}/ergenos"
packages_file="${profile_dir}/packages.x86_64"
repo_dir="${project_root}/repo"
output_dir="${ERGENOS_OUTPUT_DIR:-${project_root}/out}"
work_dir="${ERGENOS_WORK_DIR:-/var/tmp/ergenos-work-${USER:-builder}-$$}"
version="$(<"${project_root}/VERSION")"
release_dir="${ERGENOS_RELEASE_DIR:-${project_root}/release-${version}}"
architecture="x86_64"
installation_dir="ergenos"
iso_path="${output_dir}/ergenos-${version}-${architecture}.iso"
rebuild_packages=false
validate_only=false
create_release_parts=false
pacman_config=""
postcheck_dir=""

usage() {
    cat <<'EOF'
Usage: ./build.sh [OPTIONS]

Options:
  --rebuild-packages  Rebuild local packages instead of reusing them
  --validate-only     Validate the profile and package resolution, then exit
  --release-parts     Split the finished ISO into two GitHub release assets
  -h, --help          Show this help

Environment variables:
  ERGENOS_OUTPUT_DIR  ISO output directory (default: ./out)
  ERGENOS_WORK_DIR    Archiso work directory (default: unique /var/tmp path)
  ERGENOS_RELEASE_DIR Release asset directory (default: ./release-VERSION)
EOF
}

die() {
    printf 'ERROR: %s\n' "$*" >&2
    exit 1
}

cleanup() {
    [[ -z "${pacman_config}" ]] || rm -f -- "${pacman_config}"
    [[ -z "${postcheck_dir}" ]] || rm -rf -- "${postcheck_dir}"
}
trap cleanup EXIT

while (($#)); do
    case "$1" in
        --rebuild-packages)
            rebuild_packages=true
            ;;
        --validate-only)
            validate_only=true
            ;;
        --release-parts)
            create_release_parts=true
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

required_commands=(makepkg repo-add pacman mkarchiso pacman-conf sudo sed grep sort find awk sha256sum xorriso)
if [[ "${create_release_parts}" == true ]]; then
    required_commands+=(split)
fi

for command_name in "${required_commands[@]}"; do
    command -v "${command_name}" >/dev/null || die "Missing required command: ${command_name}"
done

validate_profile() {
    printf 'Validating Archiso profile...\n'

    [[ "${version}" =~ ^[0-9]+\.[0-9]+\.[0-9]+-[a-z0-9.-]+$ ]] \
        || die "Invalid VERSION value: ${version}"
    [[ -s "${packages_file}" ]] || die "Missing or empty package list: ${packages_file}"

    if ! LC_ALL=C sort -c "${packages_file}" 2>/dev/null; then
        die "Package list is not sorted: ${packages_file}"
    fi
    if [[ -n "$(sort "${packages_file}" | uniq -d)" ]]; then
        die "Package list contains duplicate entries"
    fi

    mapfile -t kernel_packages < <(grep -E '^linux($|-lts$|-zen$|-hardened$)' "${packages_file}")
    ((${#kernel_packages[@]} == 1)) \
        || die "Exactly one supported kernel must be listed, found: ${#kernel_packages[@]}"

    kernel_package="${kernel_packages[0]}"
    kernel_image="vmlinuz-${kernel_package}"
    initramfs_image="initramfs-${kernel_package}.img"

    boot_configs=(
        "${profile_dir}/efiboot/loader/entries/01-archiso-linux.conf"
        "${profile_dir}/efiboot/loader/entries/02-archiso-speech-linux.conf"
        "${profile_dir}/grub/grub.cfg"
        "${profile_dir}/grub/loopback.cfg"
        "${profile_dir}/syslinux/archiso_pxe-linux.cfg"
        "${profile_dir}/syslinux/archiso_sys-linux.cfg"
    )

    for config_file in "${boot_configs[@]}"; do
        [[ -f "${config_file}" ]] || die "Missing boot configuration: ${config_file}"
        grep -Fq "/${kernel_image}" "${config_file}" \
            || die "${config_file} does not reference ${kernel_image}"
        grep -Fq "/${initramfs_image}" "${config_file}" \
            || die "${config_file} does not reference ${initramfs_image}"
    done

    grep -Fxq 'ergenctl' "${packages_file}" \
        || die "The ErgenCTL package is not listed"
    grep -Fxq 'ergenos-welcome' "${packages_file}" \
        || die "The ErgenOS Welcome package is not listed"
    grep -Fxq 'python' "${packages_file}" \
        || die "The python runtime required by ErgenCTL is not listed"
    grep -Fxq "BUILD_ID=\"${version}\"" "${profile_dir}/airootfs/etc/os-release" \
        || die "os-release BUILD_ID does not match VERSION"
    grep -Fq "shortVersion: \"${version}\"" \
        "${profile_dir}/airootfs/etc/calamares/branding/ergenos/branding.desc" \
        || die "Calamares shortVersion does not match VERSION"
    grep -Fxq 'Server = file:///path/to/ErgenOS-Linux/repo' "${profile_dir}/pacman.conf" \
        || die "Local repository placeholder is missing from pacman.conf"

    printf 'Profile validation passed. Kernel: %s\n' "${kernel_package}"
}

package_dirs=(
    packages/calamares
    packages/ergenctl
    packages/ergenos-welcome
    packages/gnome-shell-extension-blur-my-shell
    packages/gnome-shell-extension-dash-to-dock
    packages/gnome-shell-extension-gtk4-desktop-icons-ng
)

build_local_repository() {
    mkdir -p "${repo_dir}"

    for relative_dir in "${package_dirs[@]}"; do
        package_dir="${project_root}/${relative_dir}"
        [[ -d "${package_dir}" ]] || die "Missing local package directory: ${relative_dir}"

        mapfile -t package_files < <(
            cd "${package_dir}"
            makepkg --packagelist | grep -v -- '-debug-'
        )
        ((${#package_files[@]} > 0)) || die "No package outputs declared by ${relative_dir}"

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

    mapfile -t repo_packages < <(
        find "${repo_dir}" -maxdepth 1 -type f -name '*.pkg.tar.*' ! -name '*-debug-*' -print | sort
    )
    ((${#repo_packages[@]} > 0)) || die "No packages found for the local repository"
    repo-add -R "${repo_dir}/ergenos.db.tar.zst" "${repo_packages[@]}"
}

create_pacman_config() {
    pacman_config="$(mktemp --tmpdir ergenos-pacman.XXXXXX.conf)"
    sed "s|^Server = file:///path/to/ErgenOS-Linux/repo$|Server = file://${repo_dir}|" \
        "${profile_dir}/pacman.conf" > "${pacman_config}"
    grep -Fxq "Server = file://${repo_dir}" "${pacman_config}" \
        || die "Failed to configure the local ErgenOS repository"
}

validate_package_resolution() {
    printf 'Validating package availability...\n'
    mapfile -t requested_packages < <(grep -Ev '^[[:space:]]*(#|$)' "${packages_file}")
    mapfile -t local_package_names < <(
        for package_file in "${repo_packages[@]}"; do
            pacman -Qp -- "${package_file}" | awk '{print $1}'
        done | sort -u
    )

    official_packages=()
    for package_name in "${requested_packages[@]}"; do
        is_local=false
        for local_package_name in "${local_package_names[@]}"; do
            if [[ "${package_name}" == "${local_package_name}" ]]; then
                is_local=true
                break
            fi
        done
        if [[ "${is_local}" == false ]]; then
            official_packages+=("${package_name}")
        fi
    done

    pacman -Sp --print-format '%n' -- "${official_packages[@]}" >/dev/null \
        || die "One or more official packages cannot be resolved"
    for local_package_name in "${local_package_names[@]}"; do
        printf '%s\n' "${requested_packages[@]}" | grep -Fxq "${local_package_name}" \
            || die "Local package is built but missing from packages.x86_64: ${local_package_name}"
    done
    printf 'Package validation passed: %d packages requested.\n' "${#requested_packages[@]}"
}

validate_iso() {
    [[ -s "${iso_path}" ]] || die "Expected ISO was not created: ${iso_path}"
    iso_size="$(stat -c '%s' "${iso_path}")"
    ((iso_size >= 500000000)) || die "Generated ISO is unexpectedly small: ${iso_size} bytes"

    iso_listing="$(xorriso -indev "${iso_path}" -find / -type f -exec lsdl 2>/dev/null)"
    grep -Fq "'/${installation_dir}/boot/${architecture}/${kernel_image}'" <<<"${iso_listing}" \
        || die "ISO does not contain ${kernel_image}"
    grep -Fq "'/${installation_dir}/boot/${architecture}/${initramfs_image}'" <<<"${iso_listing}" \
        || die "ISO does not contain ${initramfs_image}"
    grep -Fq "'/loader/entries/01-archiso-linux.conf'" <<<"${iso_listing}" \
        || die "ISO does not contain the primary UEFI loader entry"

    postcheck_dir="$(mktemp -d --tmpdir ergenos-postcheck.XXXXXX)"
    xorriso -osirrox on -indev "${iso_path}" \
        -extract /loader/entries/01-archiso-linux.conf "${postcheck_dir}/loader.conf" \
        >/dev/null 2>&1
    grep -Fq "/${installation_dir}/boot/${architecture}/${kernel_image}" "${postcheck_dir}/loader.conf" \
        || die "Primary UEFI loader entry points to the wrong kernel"
    grep -Fq "/${installation_dir}/boot/${architecture}/${initramfs_image}" "${postcheck_dir}/loader.conf" \
        || die "Primary UEFI loader entry points to the wrong initramfs"

    printf 'ISO validation passed: %s\n' "${iso_path}"
}

write_checksums() {
    (
        cd "${output_dir}"
        sha256sum "$(basename -- "${iso_path}")" > SHA256SUMS
    )
    printf 'Checksum written to %s/SHA256SUMS\n' "${output_dir}"
}

write_release_parts() {
    mkdir -p "${release_dir}"
    part_prefix="${release_dir}/$(basename -- "${iso_path}").part-"
    [[ ! -e "${part_prefix}00" && ! -e "${part_prefix}01" ]] \
        || die "Release parts already exist in ${release_dir}"

    split -d -a 2 -n 2 "${iso_path}" "${part_prefix}"
    iso_name="$(basename -- "${iso_path}")"
    {
        sha256sum "${iso_path}" | awk -v name="${iso_name}" '{print $1 "  " name}'
        sha256sum "${part_prefix}00" | awk -v name="${iso_name}.part-00" '{print $1 "  " name}'
        sha256sum "${part_prefix}01" | awk -v name="${iso_name}.part-01" '{print $1 "  " name}'
    } > "${release_dir}/SHA256SUMS"
    printf 'Release assets written to %s\n' "${release_dir}"
}

validate_profile
build_local_repository
create_pacman_config
validate_package_resolution

if [[ "${validate_only}" == true ]]; then
    printf 'Validation completed successfully. No ISO was built.\n'
    exit 0
fi

[[ ! -e "${iso_path}" ]] || die "Output ISO already exists: ${iso_path}"
if [[ -e "${work_dir}" ]]; then
    [[ -d "${work_dir}" && -z "$(find "${work_dir}" -mindepth 1 -maxdepth 1 -print -quit)" ]] \
        || die "Work directory already exists and is not empty: ${work_dir}"
fi

mkdir -p "${output_dir}"
printf 'Building ErgenOS %s\n' "${version}"
printf 'Work directory: %s\n' "${work_dir}"
printf 'Output directory: %s\n' "${output_dir}"

sudo mkarchiso -v -r \
    -C "${pacman_config}" \
    -w "${work_dir}" \
    -o "${output_dir}" \
    "${profile_dir}"

validate_iso
write_checksums
if [[ "${create_release_parts}" == true ]]; then
    write_release_parts
fi

printf 'Build completed successfully.\n'
