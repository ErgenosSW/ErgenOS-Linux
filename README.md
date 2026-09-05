# ErgenOS

<p align="center">
  <img src="assets/ergenos-logo.png" alt="ErgenOS logo" width="320">
</p>

[![Release](https://img.shields.io/badge/release-0.1.2--alpha-orange)](https://github.com/ErgenosSW/ErgenOS-Linux/releases)
[![License](https://img.shields.io/badge/license-GPL--3.0--or--later-blue)](LICENSE)

ErgenOS is an independent Arch Linux based distribution built around GNOME, Btrfs recovery and a graphical installer. It uses Arch repositories and the rolling release model while adding its own installation workflow, system defaults and recovery setup.

The current development version is **0.1.2 Alpha - "HowDoesItStillWork"**. It is an early development release intended for testing and evaluation, not production use.

## Current state

ErgenOS currently includes:

- an Archiso live environment with GNOME on Wayland
- the `linux-zen` kernel
- Calamares with automatic and manual partitioning
- a choice of official repositories only, `yay`, `paru` or Chaotic-AUR during installation
- Zsh with a preconfigured Powerlevel10k profile
- ErgenOS artwork and GNOME defaults
- [ErgenCTL](https://github.com/ErgenosSW/ErgenCTL)
- ArcMenu, Dash to Dock, Blur My Shell, Caffeine and GTK4 Desktop Icons NG

The live image uses Nouveau. Selection of proprietary NVIDIA drivers in the installer is not implemented yet.

## Installation and recovery

Calamares installs the system and applies the software source selected by the user. The optional `yay`, `paru` and Chaotic-AUR paths require an internet connection during installation.

Btrfs installations configure Snapper for the root filesystem. `snap-pac` creates pre and post snapshots during Pacman transactions, and `grub-btrfs` adds those snapshots to the GRUB menu.

A snapshot can be booted as an earlier system state. ErgenOS includes `grub-btrfs-overlayfs`, which adds a temporary writable overlay while the snapshot itself remains read-only. Normal boot entries keep hibernation support, while snapshot entries use `noresume` to avoid resuming into historical system state.

This recovery setup is only enabled for Btrfs installations.

## ErgenCTL

ErgenOS includes [ErgenCTL](https://github.com/ErgenosSW/ErgenCTL), installed as the native `ergenctl` command in both the live environment and the installed system. Documentation and development history are maintained in its separate repository.

## Building the ISO

Build on an up-to-date Arch Linux system with `archiso`, `base-devel` and `git` installed:

```bash
git clone https://github.com/ErgenosSW/ErgenOS-Linux.git
cd ErgenOS-Linux
./build.sh
```

The finished ISO is written to `out/`. The script builds the required local packages, creates the local package repository and uses an isolated Archiso work directory under `/var/tmp`.

Useful options:

```bash
./build.sh --validate-only
./build.sh --rebuild-packages
./build.sh --release-parts
ERGENOS_WORK_DIR=/var/tmp/ergenos-work ./build.sh
ERGENOS_OUTPUT_DIR=/path/to/output ./build.sh
```

Every completed build is checked for the expected kernel, initramfs and primary UEFI entry. The script also writes `SHA256SUMS` to the output directory. The `--release-parts` option creates two numbered ISO parts and their checksums for a GitHub release.

Keep Archiso work directories outside the repository. They contain temporary pseudo-filesystem mounts that should not be scanned by Git, indexers or backup tools.

## Download

The latest published image is ErgenOS 0.1.1 Alpha. The complete ISO is available from [Google Drive](https://drive.google.com/file/d/1pFa6edmkD0YLkyLpWzXjpHCA-onA7QmG/view?usp=sharing).

Verify it after downloading:

```bash
echo "cd287cffbd8594fa0c47841c95e6162aad983e72a4ada623c7815592e470b449  ergenos-0.1.1-alpha-x86_64.iso" | sha256sum -c -
```

The [v0.1.1-alpha GitHub release](https://github.com/ErgenosSW/ErgenOS-Linux/releases/tag/v0.1.1-alpha) also provides the ISO in two numbered parts because each release asset must remain below the GitHub size limit. Reassemble and verify it with:

```bash
cat ergenos-0.1.1-alpha-x86_64.iso.part-* > ergenos-0.1.1-alpha-x86_64.iso
sha256sum -c SHA256SUMS --ignore-missing
```

Expected SHA-256 for the complete image:

```text
cd287cffbd8594fa0c47841c95e6162aad983e72a4ada623c7815592e470b449
```

## Tested so far

Version 0.1.2 Alpha has been tested with:

- UEFI installation under QEMU/KVM
- installation on a Lenovo ThinkPad E14 Gen 2
- official repositories, multilib and Flathub
- the `yay`, `paru` and Chaotic-AUR installer options
- automatic Pacman snapshots
- snapshot boot with an overlay root
- hibernation on a normal boot and disabled resume when booting a snapshot
- Wi-Fi, Bluetooth, Bluetooth audio, suspend and hardware function keys

Hardware coverage and long-term upgrade testing are still limited.

## Project direction

ErgenOS is being developed as a gaming focused Arch Linux distribution that keeps the benefits of rolling release while putting more emphasis on practical stability and recovery after a problematic update.

Version 0.1.2 Alpha adds the first-login experience and improves access to the installer in the live environment. A broader gaming setup is a development goal and is not part of the current release yet.

## Known limitations

- Secure Boot is not supported.
- Proprietary NVIDIA driver selection is not available in the installer.
- Optional software source setup requires network access during installation.
- ErgenOS does not maintain a separate binary mirror for Arch packages.
- Hardware coverage and long-term upgrade testing are limited.

See [CHANGELOG.md](CHANGELOG.md) for release-specific changes.

## Contributing and licensing

Bug reports should include the ErgenOS version, firmware mode, root filesystem, selected software source and relevant Calamares or system journal output. Issues and pull requests are welcome.

ErgenOS is not affiliated with or endorsed by Arch Linux. Arch Linux and related marks belong to their respective owners.

Original ErgenOS work is licensed under GPL-3.0-or-later. Bundled and adapted third-party components keep their respective licenses and copyright notices. See [LICENSE](LICENSE) and [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).
