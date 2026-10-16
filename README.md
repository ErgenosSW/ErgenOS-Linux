# ErgenOS

<p align="center">
  <img src="assets/ergenos-logo.png" alt="ErgenOS logo" width="320">
</p>

[![Release](https://img.shields.io/badge/release-1.2-blue)](https://www.mediafire.com/file/5pflsx05qjzptld/ergenos-1.2.0-x86_64.iso/file)
[![Website](https://img.shields.io/badge/website-ergenossw.github.io-0aa7ff)](https://ergenossw.github.io/ErgenOS-Website/)
[![License](https://img.shields.io/badge/license-GPL--3.0--or--later-blue)](LICENSE)

ErgenOS is an independent Arch Linux based distribution built around GNOME, Btrfs recovery and a graphical installer. It uses Arch repositories and the rolling release model while adding its own installation workflow, system defaults and recovery setup.

The current ISO source version is **ErgenOS 1.2.0**. The rebuilt 1.2 image has
passed the maintainer's VM acceptance test. The complete image is available on
MediaFire and as two verified parts in the [GitHub release](https://github.com/ErgenosSW/ErgenOS-Linux/releases/tag/v1.2.0).

## What's new in 1.2

- Default ErgenOS theme for GNOME Shell, GTK3 and GTK4/libadwaita, including Nautilus.
- Redesigned ErgenCTL, ErgenPac and Welcome interfaces with a shared visual style.
- ErgenPac 1.0.1: optional gaming launchers and tools, with automatic catalog refresh.
- AMD/Intel + NVIDIA hybrid graphics profiles and expanded ErgenCTL GPU diagnostics.
- ErgenCTL verification after ErgenPac system updates and native Gaming installations.
- A focused installed-system GRUB menu: ErgenOS Linux, Advanced options and
  ErgenOS Snapshots when Snapper/Btrfs recovery is configured.

| Component | Version used for 1.2 |
| --- | --- |
| ErgenPac | 1.0.1-1 |
| ErgenCTL | 1.1.0.dev-9 |
| ErgenOS Welcome | 1.0.3-1 |
| ErgenOS theme | 1.2.0-2 |

See [CHANGELOG.md](CHANGELOG.md) for details and test scope.

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

See the [installation guide](https://ergenossw.github.io/ErgenOS-Wiki/getting-started/installation.html) and [recovery documentation](https://ergenossw.github.io/ErgenOS-Wiki/recovery/).

## ErgenOS applications

ErgenOS includes [ErgenCTL](https://github.com/ErgenosSW/ErgenCTL), [ErgenOS Welcome](https://github.com/ErgenosSW/ErgenOS-Welcome), and [ErgenPac](https://github.com/ErgenosSW/ErgenPac) in both the live environment and the installed system. ErgenPac uses the signed ErgenOS repository configured in Pacman for system and first-party application updates.

## Download

Visit the [official ErgenOS website](https://ergenossw.github.io/ErgenOS-Website/) or [download the complete ErgenOS 1.2 ISO from MediaFire](https://www.mediafire.com/file/5pflsx05qjzptld/ergenos-1.2.0-x86_64.iso/file).

For image verification and installation steps, follow the [installation guide](https://ergenossw.github.io/ErgenOS-Wiki/getting-started/installation.html). Experimental post-install support is documented in the [Secure Boot guide](https://ergenossw.github.io/ErgenOS-Wiki/security/secure-boot.html).

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

For 1.2, the maintainer confirmed the rebuilt ISO in a VM, including the desktop,
ErgenPac Gaming and the three-entry GRUB menu. The theme and hybrid GPU workflow
were also accepted on the existing Acer laptop installation. This does not
constitute a new NVIDIA Secure Boot validation on that laptop.

Hardware coverage and long-term upgrade testing are still limited.

## Build validation note

The 1.2 acceptance image was built directly with `mkarchiso` in an Arch container
on Debian 13. It used signed published application packages and a local theme
repository. Six ErgenCTL repair tests failed during the earlier container source
build; their cause remains unresolved. Do not interpret the successful ISO build
as a successful run of that source-build test suite.

## Project direction

ErgenOS is moving toward an approachable gaming desktop built on system
management and recovery. Version 1.2 adds optional gaming setup through ErgenPac;
launchers and performance tools are not installed or enabled indiscriminately.

Gaming Check, a guided gaming onboarding flow, per-game launch profiles, deeper
laptop power diagnostics and expanded automatic Live recovery are deferred to
the 1.3 roadmap. They are not shipped as completed 1.2 features.

## Known limitations

See [known limitations](https://ergenossw.github.io/ErgenOS-Wiki/getting-started/known-limitations.html) and [hardware compatibility](https://ergenossw.github.io/ErgenOS-Wiki/hardware/) in the wiki. See [CHANGELOG.md](CHANGELOG.md) for release-specific changes.

## Contributing and licensing

Use the [bug report form](https://github.com/ErgenosSW/ErgenOS-Linux/issues/new?template=01-bug-report.yml) or [feature request form](https://github.com/ErgenosSW/ErgenOS-Linux/issues/new?template=02-feature-request.yml). Reports can be written in English or Polish.

For bug reports, follow the [reporting guide](https://ergenossw.github.io/ErgenOS-Wiki/troubleshooting/reporting-issues.html). Issues and pull requests are welcome.

ErgenOS is not affiliated with or endorsed by Arch Linux. Arch Linux and related marks belong to their respective owners.

Original ErgenOS work is licensed under GPL-3.0-or-later. Bundled and adapted third-party components keep their respective licenses and copyright notices. See [LICENSE](LICENSE) and [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).

## ISO 1.2 integrity

File: `ergenos-1.2.0-x86_64.iso` - 2,751,954,944 bytes (2.56 GiB).

SHA-256 checksum for the complete ISO:

```text
c152f4881a2bd0c3a8921f2139a2e3a538cd6cd49160e90cac6650df2a47599b  ergenos-1.2.0-x86_64.iso
```
