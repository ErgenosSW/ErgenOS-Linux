# ErgenOS

[![Release](https://img.shields.io/github/v/release/ErgenosSW/ErgenOS-Linux?include_prereleases&label=release)](https://github.com/ErgenosSW/ErgenOS-Linux/releases)
[![License](https://img.shields.io/badge/license-GPL--3.0--or--later-blue)](LICENSE)

ErgenOS is an independent Arch Linux derivative focused on an integrated GNOME installation and recovery workflow. The project ships an Archiso profile, a Calamares configuration, distribution defaults and the local packages required to produce the installation image.

The current release is **0.1.0 Alpha**. It is intended for evaluation and development, not production deployment.

## System composition

| Component | Implementation |
| --- | --- |
| Live environment | Archiso, GNOME on Wayland |
| Installer | Calamares |
| Kernel | `linux-zen` |
| Bootloader | GRUB with `os-prober` |
| Package sources | Arch repositories, multilib, optional AUR helper or Chaotic-AUR |
| Application distribution | Pacman and Flatpak/Flathub |
| Btrfs integration | Snapper, `snap-pac`, `grub-btrfs`, `grub-btrfs-overlayfs` |
| Shell | Zsh with a preconfigured Powerlevel10k profile |

The GNOME session includes ErgenOS defaults and artwork together with ArcMenu, Dash to Dock, Blur My Shell, Caffeine and GTK4 Desktop Icons NG.

## Installer behavior

Calamares provides automatic and manual partitioning with Btrfs, ext4, XFS and F2FS root filesystem support. GRUB is installed as the system bootloader.

The software-source page applies exactly one of the following configurations to the target system:

| Selection | Target configuration |
| --- | --- |
| Official repositories only | Arch repositories, multilib and Flathub |
| AUR with yay | Official configuration plus `yay` |
| AUR with paru | Official configuration plus `paru` |
| Chaotic-AUR | Official configuration plus the Chaotic-AUR keyring, mirror list and repository |

The AUR and Chaotic-AUR are external to the official Arch Linux repositories and have separate trust and maintenance models.

## Btrfs recovery model

For Btrfs installations, the installer creates the subvolume layout and configures Snapper for the root filesystem. Pacman transactions generate paired pre/post snapshots through `snap-pac`. `grub-btrfsd` regenerates snapshot entries for GRUB.

Snapshot entries boot through `grub-btrfs-overlayfs`: the selected snapshot is used as a read-only lower layer and runtime changes are written to a temporary overlay. Snapshot kernel entries include `noresume`, preventing hibernation resume attempts against historical system state. Normal boot entries retain the configured resume device.

This integration is not installed for non-Btrfs root filesystems.

## Building

Build on an up-to-date Arch Linux host with `archiso`, `base-devel` and `git` installed:

```bash
git clone https://github.com/ErgenosSW/ErgenOS-Linux.git
cd ErgenOS-Linux
./build.sh
```

`build.sh` performs the distribution-specific build orchestration:

- builds or reuses the required local packages;
- generates the local package repository database;
- creates a temporary Pacman configuration with the resolved repository path;
- allocates an isolated Archiso work directory under `/var/tmp`;
- writes the resulting image to `out/`.

Available controls:

```bash
./build.sh --rebuild-packages
ERGENOS_WORK_DIR=/var/tmp/ergenos-work ./build.sh
ERGENOS_OUTPUT_DIR=/path/to/output ./build.sh
```

Archiso work directories must remain outside the repository. They contain temporary pseudo-filesystem mounts that must not be traversed by Git, indexers or backup tools.

## Release artifacts

GitHub limits individual release assets to 2 GiB, so the 0.1.0 Alpha ISO is published in numbered parts. Reassemble and verify it with:

```bash
cat ergenos-0.1.0-alpha-x86_64.iso.part-* > ergenos-0.1.0-alpha-x86_64.iso
sha256sum -c SHA256SUMS --ignore-missing
```

Expected SHA-256 for the complete image:

```text
e19f4098f04b4f5d5fc5ba29ff46014d394c52930aa2d8ef8dd69cef556efad4
```

Release artifacts are available from [GitHub Releases](https://github.com/ErgenosSW/ErgenOS-Linux/releases).

## Validation status

Version 0.1.0 Alpha has been validated with:

- UEFI installation under QEMU/KVM;
- installation on a Lenovo ThinkPad E14 Gen 2;
- official repositories, multilib and Flathub;
- `yay`, `paru` and Chaotic-AUR installer paths;
- automatic pre/post snapshots for Pacman transactions;
- read-only snapshot boot through an overlay root;
- snapshot-specific `noresume` and normal-system hibernation;
- Wi-Fi, Bluetooth, Bluetooth audio, suspend and hardware function keys.

## Known limitations

- Secure Boot is not supported.
- Proprietary NVIDIA driver selection is not implemented; the live image uses Nouveau.
- Hardware coverage and long-term upgrade testing are currently limited.
- Optional software-source configuration requires network access during installation.
- ErgenOS does not provide an independent binary mirror for the Arch package set.

See [CHANGELOG.md](CHANGELOG.md) for release-specific changes.

## Contributing

Issues and pull requests should identify the ErgenOS version, firmware mode, filesystem, software-source selection and relevant Calamares or system journal output. Reproduction against the current `main` branch is preferred.

## Independence and licensing

ErgenOS is not affiliated with or endorsed by Arch Linux. Arch Linux and related marks belong to their respective owners.

Original ErgenOS work is licensed under GPL-3.0-or-later. Bundled and adapted third-party components retain their respective licenses and copyright notices. See [LICENSE](LICENSE) and [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).
