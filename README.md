# ErgenOS

<p align="center">
  <img src="assets/ergenos-logo.png" alt="ErgenOS logo" width="320">
</p>

[![Release](https://img.shields.io/github/v/release/ErgenosSW/ErgenOS-Linux?include_prereleases&label=release)](https://github.com/ErgenosSW/ErgenOS-Linux/releases)
[![License](https://img.shields.io/badge/license-GPL--3.0--or--later-blue)](LICENSE)

ErgenOS is an independent Arch Linux based distribution built around GNOME, Btrfs recovery and a graphical installer. It uses Arch repositories and the rolling release model while adding its own installation workflow, system defaults and recovery setup.

The current release is **0.1.0 Alpha - "Somehow Booted"**. It is an early development release intended for testing and evaluation, not production use.

## Current state

ErgenOS currently includes:

- an Archiso live environment with GNOME on Wayland
- the `linux-zen` kernel
- Calamares with automatic and manual partitioning
- Btrfs, ext4, XFS and F2FS root filesystem support
- GRUB with `os-prober`
- Arch repositories, multilib and Flathub
- a choice of official repositories only, `yay`, `paru` or Chaotic-AUR during installation
- Zsh with a preconfigured Powerlevel10k profile
- ErgenOS artwork and GNOME defaults
- ErgenCTL system diagnostics and snapshot recovery utility
- ArcMenu, Dash to Dock, Blur My Shell, Caffeine and GTK4 Desktop Icons NG

The live image uses Nouveau. Selection of proprietary NVIDIA drivers in the installer is not implemented yet.

## Installation and recovery

Calamares installs the system and applies the software source selected by the user. The optional `yay`, `paru` and Chaotic-AUR paths require an internet connection during installation.

Btrfs installations configure Snapper for the root filesystem. `snap-pac` creates pre and post snapshots during Pacman transactions, and `grub-btrfs` adds those snapshots to the GRUB menu.

A snapshot can be booted as an earlier system state. ErgenOS includes `grub-btrfs-overlayfs`, which adds a temporary writable overlay while the snapshot itself remains read-only. Normal boot entries keep hibernation support, while snapshot entries use `noresume` to avoid resuming into historical system state.

This recovery setup is only enabled for Btrfs installations.

## ErgenCTL

The current development tree includes ErgenCTL 0.1.1-alpha. It is installed as the native `ergenctl` command in both the live environment and the installed system.

Inspect the system:

```bash
ergenctl status
sudo ergenctl doctor
sudo ergenctl resume
```

Inspect and apply supported repairs:

```bash
sudo ergenctl fix all --dry-run
sudo ergenctl fix all --yes
```

When the normal system cannot boot, start a working snapshot from GRUB and inspect the base installation with `ergenctl`. A selected snapshot can be restored as the new writable root:

```bash
sudo ergenctl rollback SNAPSHOT_NUMBER --dry-run
sudo ergenctl rollback SNAPSHOT_NUMBER --yes
```

ErgenCTL preserves the replaced root subvolume during rollback. Its repository and complete command reference are available at [ErgenosSW/ErgenCTL](https://github.com/ErgenosSW/ErgenCTL).

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
./build.sh --rebuild-packages
ERGENOS_WORK_DIR=/var/tmp/ergenos-work ./build.sh
ERGENOS_OUTPUT_DIR=/path/to/output ./build.sh
```

Keep Archiso work directories outside the repository. They contain temporary pseudo-filesystem mounts that should not be scanned by Git, indexers or backup tools.

## Download

The complete ErgenOS 0.1.0 Alpha ISO is available from [Google Drive](https://drive.google.com/file/d/1OIWWb0160muhsvHi2fkKwQrEAfSFjlA1/view?usp=sharing).

Verify it after downloading:

```bash
echo "e19f4098f04b4f5d5fc5ba29ff46014d394c52930aa2d8ef8dd69cef556efad4  ergenos-0.1.0-alpha-x86_64.iso" | sha256sum -c -
```

The [v0.1.0-alpha GitHub release](https://github.com/ErgenosSW/ErgenOS-Linux/releases/tag/v0.1.0-alpha) also provides the ISO in numbered parts because each release asset must remain below the GitHub size limit. Reassemble and verify it with:

```bash
cat ergenos-0.1.0-alpha-x86_64.iso.part-* > ergenos-0.1.0-alpha-x86_64.iso
sha256sum -c SHA256SUMS --ignore-missing
```

Expected SHA-256 for the complete image:

```text
e19f4098f04b4f5d5fc5ba29ff46014d394c52930aa2d8ef8dd69cef556efad4
```

## Tested so far

Version 0.1.0 Alpha has been tested with:

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

Version 0.1.0 Alpha establishes the installer, desktop and recovery foundation. A broader gaming setup is a development goal and is not part of the current release yet.

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
