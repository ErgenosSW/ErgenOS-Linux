# ErgenOS 1.3 roadmap

This is the canonical release checklist for ErgenOS 1.3. The feature scope is
frozen. The published system remains ErgenOS 1.2 until all acceptance and
publication gates below are completed. A merged implementation, built package
and accepted target-system behavior are recorded separately; one does not imply
the others.

## Completed foundation

- [x] Offline Gaming Check in ErgenCTL CLI and GUI.
- [x] Gaming Check regression coverage and signed ErgenCTL 1.1.0.dev-12 package.
- [x] Dual-GPU diagnostics and post-update verification inherited from 1.2.
- [x] Serialized GRUB snapshot-menu refresh after package transactions.
- [x] Automated Archiso profile tests and release-tag ISO artifact workflow.
- [x] Signed package repository validation.
- [x] Optional ErgenOS Hyprland preview 0.1.0-33 in the package repository.
- [x] Hyprland Power UI with shared power-profiles-daemon profiles, battery
      details, independent AC/battery idle timers and lid-action settings.
- [x] Install and enable power-profiles-daemon explicitly in the default GNOME
      image so profile selection remains shared with the Hyprland preview.
- [x] ErgenPac consumes the read-only ErgenCTL Gaming Check report.
- [x] Optional signed ErgenProton-WoW 0.2.0-1 package in the repository; it is
      intentionally not promoted or installed automatically by ErgenPac.

## Deferred beyond 1.3

The following ideas are not release blockers and are not claimed as 1.3
features:

- guided Gaming Setup beyond the existing explicit per-tool ErgenPac catalog
- persistent per-game launch-profile management
- ErgenProton-WoW promotion or automatic installation in ErgenPac
- expanded default-GNOME battery diagnostics beyond the existing GNOME and
  Hyprland power-profile controls
- automatic installed-system discovery from live media

## Package and ISO integration

- [x] Prepare ISO recipes for ErgenCTL 1.1.0.dev-13 and ErgenPac 1.0.1-3 from
      pinned published source commits.
- [ ] Build, sign and publish ErgenCTL 1.1.0.dev-13 and ErgenPac 1.0.1-3.
- [ ] Update the signed Pacman repository and validate both databases/signatures.
- [x] Set VERSION, os-release and Calamares branding to 1.3.0 after scope freeze.
- [x] Complete the pre-release 1.3 changelog and component-version table.
- [x] Refresh the three locally packaged GNOME extensions for GNOME Shell 51
      and reject incompatible extension metadata during profile validation.
- [ ] Build the ISO from reviewed, published and reproducible package sources.

## Acceptance gates

- [ ] All repository test workflows pass on the intended release commits.
- [ ] Clean UEFI installation and first boot pass in a fresh VM.
- [ ] Upgrade from ErgenOS 1.2 succeeds without dependency downgrades or conflicts.
- [ ] Snapshot creation, GRUB snapshot menu, snapshot boot and rollback pass.
- [ ] Live recovery remains manually targeted and successfully repairs the intended
      installation; automatic disk discovery is not part of 1.3.
- [ ] ErgenPac Gaming and Gaming Check pass on the Acer Nitro hybrid-GPU system.
- [ ] Power Saver, Balanced and Performance selection is visible in GNOME and
      remains synchronized after switching between GNOME and Hyprland.
- [ ] GNOME remains the supported default; Hyprland preview remains optional unless
      a separate scope decision promotes it.
- [ ] Dash to Dock, Blur My Shell and GTK4 Desktop Icons NG load in a clean live
      GNOME session and remain enabled after installation.
- [ ] Secure Boot/MOK, signed kernel/GRUB and snapshot-menu behavior pass in QEMU.
- [ ] Final ISO size, contents and SHA-256 are recorded and independently checked.

## Publication gates

- [ ] Create the reviewed v1.3.0 tag and verify the GitHub Actions build.
- [ ] Publish the complete ISO and checksum plus any split GitHub assets.
- [ ] Verify the public download by downloading and checking its SHA-256.
- [ ] Update README, Website and both Wiki languages with final URLs and evidence.
- [ ] Keep historical 1.2 documentation available and clearly versioned.

## Explicitly not claimed yet

- ErgenOS 1.3 is not released.
- Guided Gaming Setup, per-game profiles and automatic Live discovery are not
  part of the frozen 1.3 scope.
- ErgenProton-WoW is an optional repository package and is not automatically
  configured by ErgenPac or third-party launchers.
- The Hyprland preview is not part of the default GNOME installation image.
- Green unit tests do not replace installation, upgrade, recovery or hardware
  acceptance testing.
