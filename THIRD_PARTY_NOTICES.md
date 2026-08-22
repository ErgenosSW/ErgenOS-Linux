# Third-party notices

ErgenOS is an independent project assembled from free and open-source software. Components retain their original copyrights, licenses and trademarks. The ErgenOS project license does not replace the licenses of third-party components or packages included in a generated ISO image.

Copyright in original ErgenOS code, configuration and artwork belongs to the ErgenOS contributors. Those original portions are licensed under GPL-3.0-or-later as stated in the repository `LICENSE` file. Files that carry their own license notice remain under that notice.

## Arch Linux and Archiso

The ErgenOS build profile is derived from the Archiso releng profile.

- Project: https://gitlab.archlinux.org/archlinux/archiso
- License: GNU General Public License v3.0 or later

Arch Linux and the Arch Linux logo are trademarks of their respective owners. ErgenOS is not affiliated with, sponsored by or endorsed by Arch Linux. The name Arch Linux is used only to identify the upstream distribution from which ErgenOS is derived.

## Calamares

ErgenOS builds and distributes a customized Calamares installer package.

- Project: https://codeberg.org/Calamares/calamares
- License: GNU General Public License v3.0 or later
- Local packaging recipe: `packages/calamares/`

## Powerlevel10k

Powerlevel10k is vendored under `ergenos/airootfs/usr/share/zsh-theme-powerlevel10k/`.

- Project: https://github.com/romkatv/powerlevel10k
- License: MIT
- License copy: `ergenos/airootfs/usr/share/zsh-theme-powerlevel10k/LICENSE`

## GNOME Shell extensions

ErgenOS enables several independently developed GNOME Shell extensions. Packages from the official Arch Linux repositories retain the license metadata and license files supplied by those packages. Locally built extension packages are produced from the recipes stored under `packages/`.

- ArcMenu: https://gitlab.com/arcmenu/ArcMenu — GPL-2.0-or-later
- Blur My Shell: https://github.com/aunetx/blur-my-shell — MIT
- Caffeine: https://github.com/eonpatapon/gnome-shell-extension-caffeine — GPL-3.0-or-later
- Dash to Dock: https://github.com/micheleg/dash-to-dock — GPL-2.0-or-later
- GTK4 Desktop Icons NG: https://gitlab.com/smedius/desktop-icons-ng — GPL-3.0

The Blur My Shell packaging directory includes a copy of its MIT license. Other extension licenses are provided inside their source trees or installed packages as applicable.

## ErgenOS artwork

The ErgenOS logos, wallpaper and other original project branding are original ErgenOS project assets and are distributed under the project license unless a file states otherwise. They are not Arch Linux artwork and do not imply endorsement by Arch Linux.

## AUR helpers

Prebuilt helper packages are included so the installer can configure the selected software source without building packages during installation.

- yay: https://github.com/Jguer/yay — GPL-3.0-or-later
- paru: https://github.com/Morganamilo/paru — GPL-3.0-or-later

Their packaging recipes are stored under `packages/yay-bin/` and `packages/paru/`.

## Chaotic-AUR configuration packages

The live image includes `chaotic-keyring` and `chaotic-mirrorlist` packages from the Chaotic-AUR project.

- Project: https://github.com/chaotic-aur
- Package-declared license: GPL

Selecting Chaotic-AUR enables an independent third-party repository. Chaotic-AUR is not an official Arch Linux repository.

## Packages in the generated ISO

The generated ISO contains many independently developed packages from Arch Linux repositories and, depending on the installer selection, third-party sources. Each package retains its own license and copyright notices. Installed package metadata can be inspected with:

```bash
pacman -Qi <package-name>
```

License files installed by packages are generally available under `/usr/share/licenses/`.
