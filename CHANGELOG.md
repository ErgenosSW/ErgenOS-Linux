# Changelog

## [Unreleased]

## [1.2.0] - 2026-10-12

### Added

- `ergenos-theme` 1.2.0-2 as the default GNOME Shell, GTK3 and GTK4/libadwaita
  appearance; User Themes is enabled in the ISO defaults
- optional Gaming catalog in ErgenPac: Steam, Lutris, Heroic, Faugus, GameMode,
  MangoHud, GOverlay and Gamescope, with per-tool confirmation and usage hints
- combined AMD/Intel + NVIDIA driver profiles, 32-bit libraries and
  switcheroo-control integration; expanded laptop GPU diagnostics in ErgenCTL
- `ergenctl verify-update --json`, invoked by ErgenPac after updates and native
  Gaming installations to report boot, snapshot, module and service problems

### Changed

- ErgenPac 1.0.1-1, ErgenCTL 1.1.0.dev-9 and Welcome 1.0.3-1 with redesigned GUIs
- ISO, os-release and Calamares branding updated to 1.2.0
- installed GRUB menu hides firmware BootNext targets, firmware settings and
  OS-prober entries; system, advanced options and configured snapshots remain
- an installation step and package hook keep firmware entries disabled after
  installation and subsequent GRUB package updates

### Fixed

- rectangular popup backgrounds in the tested Blur My Shell configuration by
  disabling popup blur only; panel and dock blur remain separately configurable
- libadwaita styling through a dedicated GTK4 overlay and a first-login helper
  that preserves existing custom GTK CSS
- Gaming package availability refresh in an isolated checkupdates database;
  offline fallback is explicit and fakeroot is now a required ErgenPac dependency

### Validation

- ErgenPac 1.0.1: 44 tests passed; signed package and repository databases verified
- rebuilt ISO accepted by the maintainer in a VM; Gaming and the intended GRUB
  menu confirmed; theme and hybrid GPU usage confirmed on the existing laptop
- direct mkarchiso build succeeded on ErgenLab (Debian 13, Arch Docker container)
- six ErgenCTL repair tests failed in the container source-build path and remain
  unresolved; the ISO used the previously published signed ErgenCTL package
- historical Secure Boot coverage below remains valid historical evidence, not
  a claim that the complete lifecycle was repeated for 1.2

### Deferred to 1.3

Gaming Check, guided gaming onboarding, per-game launch profiles, expanded
battery/power diagnostics and automatic discovery of installed systems from
Live recovery. ErgenProton-WoW integration into the Gaming catalog is not shipped.


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
- ErgenOS Secure Boot updated to `0.2.0.dev-5`
- ErgenPac updated to `0.2.1`
- ErgenOS Welcome updated to `1.0.1`, including a shortcut to the official
  ErgenOS website
- `grub-btrfsd` now watches the complete Snapper tree so newly created
  snapshots reliably appear in the GRUB menu

### Fixed

- the signed Secure Boot GRUB loader now reads the current configuration from
  the real `/boot` filesystem, preserving the dynamic ErgenOS Snapshots menu
- required disk, filesystem and menu modules are preloaded before the signed
  loader searches for the installed system
- the embedded trusted Unicode font is loaded before switching to the on-disk
  GRUB configuration, preventing broken menu borders under Secure Boot

### Tested

- complete Secure Boot lifecycle under QEMU/KVM with OVMF
- Secure Boot activation and boot on a physical Lenovo ThinkPad
- signed and loaded `broadcom-wl-dkms` with no module verification failure
- clean ErgenOS 1.1 installation, MOK enrollment and Secure Boot activation on
  a physical Lenovo ThinkPad
- automatic snapshot-menu refresh, booting a snapshot through the signed
  loader and successful ErgenCTL rollback from an intentionally unbootable
  normal system

The ErgenOS 1.1 installation ISO itself still requires Secure Boot to be
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
