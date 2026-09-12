# Changelog

## [Unreleased]

## [1.1.0] - 2026-09-12

### Added

- experimental post-install Secure Boot support through the signed
  `ergenos-secureboot` package
- Microsoft-signed shim and user-enrolled Machine Owner Key workflow without
  replacing firmware platform keys or requiring Setup Mode
- automatic kernel and GRUB signing plus verified signing of installed DKMS
  modules, including compressed `.ko.zst` modules
- ErgenPac Driver Manager with hardware detection and guided installation of
  graphics drivers and supporting Vulkan and multilib packages
- an optional `Where Bootloader` wallpaper in the GNOME background picker

### Changed

- ErgenCTL updated to `1.1.0.dev-4`
- ErgenOS Secure Boot updated to `0.2.0.dev-2`
- ErgenPac updated to `0.2.1`
- ErgenOS Welcome updated to `1.0.1`, including a shortcut to the official
  ErgenOS website

### Tested

- complete Secure Boot lifecycle under QEMU/KVM with OVMF
- Secure Boot activation and boot on a physical Lenovo ThinkPad
- signed and loaded `broadcom-wl-dkms` with no module verification failure

The ErgenOS 1.0 installation ISO itself still requires Secure Boot to be
disabled. Support is enabled on the installed system by following the
[Secure Boot setup guide](https://ergenossw.github.io/ErgenOS-Website/secure-boot.html).

## [1.0.0] - 2026-09-07

- ErgenCTL 1.0.0, ErgenOS Welcome 1.0.0, and ErgenPac 0.1.1 included by default
- signed ErgenOS package repository enabled by default for future updates
- GNOME Tweaks included
- minimize and maximize window buttons enabled by default

All notable ErgenOS changes are documented in this file.

## [0.1.2-alpha] - 2026-09-06

### Added

- ErgenOS Welcome as the first-login application
- direct access to the ErgenOS installer from Welcome in the live environment
- an ErgenOS installer shortcut on the live desktop

### Changed

- the Welcome login preference is enabled by default on installed systems
- the Welcome preferences section is hidden in the live environment
- the generic Calamares launcher is hidden in favor of Install ErgenOS

### Fixed

- the live desktop installer shortcut is automatically marked as trusted

## [0.1.1-alpha] - 2026-09-04

### Added

- ErgenCTL 0.1.1-alpha as the native `ergenctl` command

### Fixed

- Linux Zen paths in UEFI, GRUB, Syslinux, PXE and loopback boot entries
- Broadcom driver package selection for current Arch repositories

## [0.1.0-alpha] - 2026-08-23

First public alpha.

### Included

- GNOME Wayland live environment and Calamares graphical installer
- `linux-zen`, GRUB and `os-prober`
- ext4, Btrfs, XFS and F2FS installation choices
- optional yay, paru or Chaotic-AUR configuration
- official Arch repositories, multilib, Flatpak and Flathub
- automatic Snapper snapshots around pacman transactions
- read-only snapshot boot through GRUB and `grub-btrfs-overlayfs`
- hibernation configuration with snapshot-specific `noresume`
- ErgenOS branding, wallpaper, Fastfetch logo and GNOME defaults
- Wi-Fi, Bluetooth and Bluetooth audio support

### Tested

- UEFI installation in QEMU/KVM
- physical installation on a Lenovo ThinkPad E14 Gen 2
- Wi-Fi, Bluetooth audio, suspend, hibernation and function keys
- pacman upgrades, Flatpak and AUR package installation with paru

### Known limitations

- this is pre-release software and has not received broad hardware testing
- proprietary NVIDIA installation is not implemented yet
- Secure Boot is not supported
- network access is required after installation to refresh repositories and download additional software
