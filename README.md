# ErgenOS

<p align="center">
  <img src="assets/ergenos-logo.png" alt="ErgenOS logo" width="320">
</p>

[![Release](https://img.shields.io/badge/release-1.1-blue)](https://github.com/ErgenosSW/ErgenOS-Linux/releases/tag/v1.1.0)
[![Website](https://img.shields.io/badge/website-ergenossw.github.io-0aa7ff)](https://ergenossw.github.io/ErgenOS-Website/)
[![License](https://img.shields.io/badge/license-GPL--3.0--or--later-blue)](LICENSE)

ErgenOS is an independent Arch Linux based distribution built around GNOME, Btrfs recovery and a graphical installer. It uses Arch repositories and the rolling release model while adding its own installation workflow, system defaults and recovery setup.

The current release is **ErgenOS 1.1**.

## Documentation

Visit the [ErgenOS Wiki](https://ergenossw.github.io/ErgenOS-Wiki/) for installation, system administration, security, recovery, hardware and troubleshooting guides. Available in [English](https://ergenossw.github.io/ErgenOS-Wiki/) and [Polish](https://ergenossw.github.io/ErgenOS-Wiki/pl/).

## Current state

ErgenOS currently includes:

- the `linux-zen` kernel
- Calamares with automatic and manual partitioning
- a choice of official repositories only, `yay`, `paru` or Chaotic-AUR during installation
- [ErgenCTL](https://github.com/ErgenosSW/ErgenCTL)
- [ErgenOS Welcome](https://github.com/ErgenosSW/ErgenOS-Welcome)
- [ErgenPac](https://github.com/ErgenosSW/ErgenPac)
- experimental post-install Secure Boot support through
  [ErgenOS Secure Boot](https://github.com/ErgenosSW/ErgenOS-SecureBoot)

## Installation and recovery

Calamares installs the system and applies the software source selected by the user. The optional `yay`, `paru` and Chaotic-AUR paths require an internet connection during installation.

Btrfs installations configure Snapper for the root filesystem. `snap-pac`
creates pre and post snapshots during Pacman transactions, and `grub-btrfs`
adds those snapshots to the GRUB menu. Its daemon watches the complete Snapper
tree so new recovery points are reflected automatically.

A snapshot can be booted as an earlier system state. ErgenOS includes `grub-btrfs-overlayfs`, which adds a temporary writable overlay while the snapshot itself remains read-only. Normal boot entries keep hibernation support, while snapshot entries use `noresume` to avoid resuming into historical system state.

This recovery setup is only enabled for Btrfs installations.

## ErgenOS applications

ErgenOS includes [ErgenCTL](https://github.com/ErgenosSW/ErgenCTL), [ErgenOS Welcome](https://github.com/ErgenosSW/ErgenOS-Welcome), and [ErgenPac](https://github.com/ErgenosSW/ErgenPac) in both the live environment and the installed system. ErgenPac uses the signed ErgenOS repository configured in Pacman for system and first-party application updates.

## Download

Visit the [official ErgenOS website](https://ergenossw.github.io/ErgenOS-Website/) or [download the complete ErgenOS 1.1 ISO from MediaFire](https://www.mediafire.com/file/psvdrlrwlsz2c2c/ergenos-1.1.0-x86_64.iso/file).

The current ISO must be booted and installed with Secure Boot disabled.
Experimental post-install support using Microsoft-signed shim and a locally
enrolled Machine Owner Key is available from the signed ErgenOS repository.
Follow the [Secure Boot setup guide](https://ergenossw.github.io/ErgenOS-Website/secure-boot.html)
after installation.

Verify the downloaded image with:

```bash
echo "460c2ab349681cef4922ebba35b180b24f7a17e7182dbf23cc7c99b13b1fdcce  ergenos-1.1.0-x86_64.iso" | sha256sum -c -
```

Alternatively, download both numbered ISO parts and `SHA256SUMS-1.1.0` from the [ErgenOS 1.1 GitHub release](https://github.com/ErgenosSW/ErgenOS-Linux/releases/tag/v1.1.0). Reassemble and verify the image with:

```bash
cat ergenos-1.1.0-x86_64.iso.part-* > ergenos-1.1.0-x86_64.iso
sha256sum -c SHA256SUMS-1.1.0
```

Expected SHA-256 for the complete image:

```text
460c2ab349681cef4922ebba35b180b24f7a17e7182dbf23cc7c99b13b1fdcce
```

## Tested so far

ErgenOS has been tested with:

- UEFI installation under QEMU/KVM
- installation on a Lenovo ThinkPad E14 Gen 2
- official repositories, multilib and Flathub
- the `yay`, `paru` and Chaotic-AUR installer options
- automatic Pacman snapshots
- snapshot boot with an overlay root
- snapshot discovery and ErgenCTL rollback through the signed Secure Boot GRUB
  loader after deliberately making the normal system unbootable
- hibernation on a normal boot and disabled resume when booting a snapshot
- Wi-Fi, Bluetooth, Bluetooth audio, suspend and hardware function keys
- Secure Boot through shim and MOK under QEMU/OVMF and on a Lenovo ThinkPad
- signed `linux-zen`, GRUB and `broadcom-wl-dkms` with Secure Boot enabled

Hardware coverage and long-term upgrade testing are still limited.

## Project direction

ErgenOS is currently a general-purpose Arch Linux based desktop distribution focused on approachable system management, practical stability and recovery after a problematic update.

Gaming-oriented features are part of the long-term direction, but ErgenOS does not yet present itself as a gaming distribution.

## Known limitations

- The ErgenOS 1.1 ISO is not Secure Boot bootable; experimental support is
  configured after installation.
- Optional software source setup requires network access during installation.
- ErgenOS does not maintain a separate binary mirror for Arch packages.
- Hardware coverage and long-term upgrade testing are limited.

See [CHANGELOG.md](CHANGELOG.md) for release-specific changes.

## Contributing and licensing

Bug reports should include the ErgenOS version, firmware mode, root filesystem, selected software source and relevant Calamares or system journal output. Issues and pull requests are welcome.

ErgenOS is not affiliated with or endorsed by Arch Linux. Arch Linux and related marks belong to their respective owners.

Original ErgenOS work is licensed under GPL-3.0-or-later. Bundled and adapted third-party components keep their respective licenses and copyright notices. See [LICENSE](LICENSE) and [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).
