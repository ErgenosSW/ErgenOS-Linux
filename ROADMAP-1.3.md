# ErgenOS 1.3 roadmap

This is the canonical checklist for ErgenOS 1.3 development. The published
system remains ErgenOS 1.2 until all release gates below are completed. A merged
implementation, built package and accepted target-system behavior are recorded
separately; one does not imply the others.

## Completed foundation

- [x] Offline Gaming Check in ErgenCTL CLI and GUI.
- [x] Gaming Check regression coverage and signed ErgenCTL 1.1.0.dev-12 package.
- [x] Dual-GPU diagnostics and post-update verification inherited from 1.2.
- [x] Serialized GRUB snapshot-menu refresh after package transactions.
- [x] Automated Archiso profile tests and release-tag ISO artifact workflow.
- [x] Signed package repository validation.
- [x] Optional ErgenOS Hyprland preview 0.1.0-33 in the package repository.

## Required product work

- [ ] Add a guided Gaming Setup flow to ErgenPac that consumes Gaming Check
      results and never installs or enables optional tools without confirmation.
- [ ] Add persistent, reviewable per-game launch profiles with a safe reset path.
- [ ] Add optional ErgenProton-WoW discovery/installation to the Gaming catalog.
- [ ] Expand ErgenCTL battery and power diagnostics for the default GNOME system;
      optional Hyprland controls do not satisfy this requirement.
- [ ] Discover installed ErgenOS systems from live media without mounting or
      modifying ambiguous targets automatically.
- [ ] Add tests for every new detection, profile and privileged-operation path.

## Package and ISO integration

- [x] Align ISO recipes with signed ErgenCTL 1.1.0.dev-12 and ErgenPac 1.0.1-2.
- [ ] Release and sign any newer application packages required by the product work.
- [ ] Update the signed Pacman repository and validate both databases/signatures.
- [ ] Set VERSION, os-release and Calamares branding to 1.3.0 only after scope freeze.
- [ ] Complete the 1.3 changelog and component-version table.
- [ ] Build the ISO from reviewed, published and reproducible package sources.

## Acceptance gates

- [ ] All repository test workflows pass on the intended release commits.
- [ ] Clean UEFI installation and first boot pass in a fresh VM.
- [ ] Upgrade from ErgenOS 1.2 succeeds without dependency downgrades or conflicts.
- [ ] Snapshot creation, GRUB snapshot menu, snapshot boot and rollback pass.
- [ ] Live recovery detects the intended installation and refuses ambiguous disks.
- [ ] Gaming Setup and Gaming Check pass on the Acer Nitro hybrid-GPU system.
- [ ] GNOME remains the supported default; Hyprland preview remains optional unless
      a separate scope decision promotes it.
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
  implemented merely because Gaming Check exists.
- The Hyprland preview is not part of the default GNOME installation image.
- Green unit tests do not replace installation, upgrade, recovery or hardware
  acceptance testing.
