# ErgenOS

<p align="center">
  <img src="assets/ergenos-logo.png" alt="ErgenOS logo" width="320">
</p>

[![Release](https://img.shields.io/badge/release-1.0-blue)](https://github.com/ErgenosSW/ErgenOS-Linux/releases)
[![License](https://img.shields.io/badge/license-GPL--3.0--or--later-blue)](LICENSE)

ErgenOS is an independent Arch Linux based distribution built around GNOME, Btrfs recovery and a graphical installer. It uses Arch repositories and the rolling release model while adding its own installation workflow, system defaults and recovery setup.

The current release is **ErgenOS 1.0**.

## Current state

ErgenOS currently includes:

- an Archiso live environment with GNOME on Wayland
- the `linux-zen` kernel
- Calamares with automatic and manual partitioning
- a choice of official repositories only, `yay`, `paru` or Chaotic-AUR during installation
- Zsh with a preconfigured Powerlevel10k profile
- ErgenOS artwork and GNOME defaults
- [ErgenCTL](https://github.com/ErgenosSW/ErgenCTL)
- [ErgenOS Welcome](https://github.com/ErgenosSW/ErgenOS-Welcome)
- [ErgenPac](https://github.com/ErgenosSW/ErgenPac)
- the signed ErgenOS package repository and keyring
- GNOME Tweaks
- ArcMenu, Dash to Dock, Blur My Shell, Caffeine and GTK4 Desktop Icons NG

The live image uses Nouveau. Selection of proprietary NVIDIA drivers in the installer is not implemented yet.

## Installation and recovery

Calamares installs the system and applies the software source selected by the user. The optional `yay`, `paru` and Chaotic-AUR paths require an internet connection during installation.

Btrfs installations configure Snapper for the root filesystem. `snap-pac` creates pre and post snapshots during Pacman transactions, and `grub-btrfs` adds those snapshots to the GRUB menu.

A snapshot can be booted as an earlier system state. ErgenOS includes `grub-btrfs-overlayfs`, which adds a temporary writable overlay while the snapshot itself remains read-only. Normal boot entries keep hibernation support, while snapshot entries use `noresume` to avoid resuming into historical system state.

This recovery setup is only enabled for Btrfs installations.

## ErgenCTL

ErgenOS includes [ErgenCTL](https://github.com/ErgenosSW/ErgenCTL), [ErgenOS Welcome](https://github.com/ErgenosSW/ErgenOS-Welcome), and [ErgenPac](https://github.com/ErgenosSW/ErgenPac) in both the live environment and the installed system. ErgenPac uses the signed ErgenOS repository configured in Pacman for system and first-party application updates.

## Download

Download the complete ErgenOS 1.0 ISO from [Google Drive](https://drive.google.com/file/d/1ulkFifSUPisbFc_xC41_eRFDkI1hzKlG/view?usp=sharing).

Verify the downloaded image with:

```bash
echo "236e9f6a411915e67a6800cb67cf5939cba6d30d399363c9a250186f32cba754  ergenos-1.0.0-x86_64.iso" | sha256sum -c -
```

Alternatively, download both numbered ISO parts and `SHA256SUMS` from the [ErgenOS 1.0 GitHub release](https://github.com/ErgenosSW/ErgenOS-Linux/releases/tag/v1.0.0). Reassemble and verify the image with:

```bash
cat ergenos-1.0.0-x86_64.iso.part-* > ergenos-1.0.0-x86_64.iso
sha256sum -c SHA256SUMS --ignore-missing
```

Expected SHA-256 for the complete image:

```text
236e9f6a411915e67a6800cb67cf5939cba6d30d399363c9a250186f32cba754
```

## Tested so far

ErgenOS has been tested with:

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

ErgenOS 1.0 adds the first-login experience, graphical package management and system updates, a signed first-party repository, and integrated diagnostics and recovery. A broader gaming setup remains a development goal.

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
