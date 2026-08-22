# Changelog

All notable ErgenOS changes are documented in this file.

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
