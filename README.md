# ErgenOS Linux

**Current release: 0.1.0 Alpha**

ErgenOS is an experimental, desktop-focused Linux distribution based on Arch Linux. Its goal is to provide an approachable Arch experience with a graphical installer, sensible defaults and recovery tools ready out of the box.

> [!WARNING]
> ErgenOS is alpha software under active development. It is not ready for production systems. Keep backups of important data and expect breaking changes.

## Highlights

- Arch Linux base with access to the official repositories
- GNOME desktop running on Wayland
- `linux-zen` kernel
- Calamares graphical installer
- GRUB bootloader with `os-prober`
- Btrfs, ext4, XFS and F2FS installation options
- Btrfs snapshots created automatically around pacman transactions
- Bootable Btrfs snapshots in GRUB through `grub-btrfs`
- Flatpak and Flathub enabled by default
- Zsh with Powerlevel10k and a preconfigured ErgenOS profile
- ArcMenu, Dash to Dock, Blur My Shell, Caffeine and GTK4 Desktop Icons NG
- ErgenOS artwork, login-screen branding and desktop wallpaper

## Software sources

The installer lets the user select one of four software-source configurations:

| Option | Result |
| --- | --- |
| Official repositories only | Arch repositories and Flatpak/Flathub |
| AUR with yay | Installs the `yay` AUR helper |
| AUR with paru | Installs the `paru` AUR helper |
| Chaotic-AUR | Enables the third-party Chaotic-AUR binary repository |

AUR packages and Chaotic-AUR packages are maintained outside the official Arch Linux repositories. Users should review packages and understand the additional trust involved before installing them.

## Snapshot and rollback support

On Btrfs installations, ErgenOS configures Snapper and `snap-pac`. Pacman transactions create pre/post snapshots automatically. `grub-btrfs` adds available snapshots to the GRUB menu, and the initramfs includes overlay support so a snapshot can be booted without modifying it.

Snapshot integration is only available when the installed root filesystem is Btrfs.

## Building the ISO

The profile is intended to be built on an up-to-date Arch Linux system.

### 1. Install the build tools

```bash
sudo pacman -Syu --needed archiso base-devel git
```

### 2. Clone the repository

```bash
git clone https://github.com/ErgenosSW/ErgenOS-Linux.git
cd ErgenOS-Linux
```

### 3. Build ErgenOS

Keep the temporary build directory outside the repository. This prevents indexing tools and editors from touching temporary pseudo-filesystems created by Archiso.

```bash
./build.sh
```

The script builds the required local packages when needed, creates the temporary package repository and passes a generated Pacman configuration to Archiso. It uses a unique work directory under `/var/tmp`, preventing stale Archiso state from being reused. The resulting ISO is placed in `out/`.

Use `./build.sh --rebuild-packages` to rebuild all local packages even when package files already exist. `ERGENOS_WORK_DIR` and `ERGENOS_OUTPUT_DIR` can override the default directories.

## Testing

The safest way to test ErgenOS is with QEMU/KVM and virt-manager:

1. Create a new UEFI virtual machine.
2. Give it at least 4 GiB of memory and 40 GiB of storage.
3. Attach the generated ISO and boot the live environment.
4. Run the ErgenOS Installer.
5. After installation, detach the ISO before rebooting.

Always verify destructive partitioning operations carefully. The **Erase disk** option deletes all data on the selected disk.

## Project status: Alpha

ErgenOS 0.1.0-alpha has been tested in QEMU/KVM and on a Lenovo ThinkPad E14 Gen 2:

- graphical installation with GRUB
- GNOME login and desktop session
- official repositories, multilib and Flathub
- `yay` and `paru` installation choices
- Chaotic-AUR installation choice
- automatic Snapper snapshots
- booting a Btrfs snapshot from GRUB with an overlay filesystem
- Wi-Fi, Bluetooth and Bluetooth audio
- suspend, hibernation and laptop function keys
- installation of an AUR package with paru

Proprietary NVIDIA drivers, Secure Boot, broader hardware compatibility and long-term upgrade scenarios still require further work and testing. See [CHANGELOG.md](CHANGELOG.md) for release details.

## Contributing

Bug reports, testing results and pull requests are welcome. When reporting an installer problem, include:

- whether the VM or computer uses BIOS or UEFI,
- the selected filesystem,
- the selected software-source option,
- the relevant Calamares or system journal output.

## Credits

ErgenOS builds on the work of Arch Linux, Archiso, Calamares, GNOME, Snapper, grub-btrfs, Flatpak and the wider free and open-source software community.

Arch Linux is a trademark of its respective owner. ErgenOS is an independent project and is not affiliated with or endorsed by Arch Linux.

## License

Original ErgenOS work is released under the GNU General Public License v3.0 or later. Third-party components retain their own licenses. See [LICENSE](LICENSE) and [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md) for details.
