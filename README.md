<div align="center">

<img src="https://raw.githubusercontent.com/NixOS/nixos-artwork/master/logo/nix-snowflake-colours.svg" width="120" alt="Nix logo" />

# nix-config

**My personal NixOS setup: niri, DankMaterialShell, and a gaming-ready desktop.**

</div>

## About

This is the configuration of my own machine. The goal is simple: keep as little bloat as possible, know exactly what is on my system, and be able to rebuild it from scratch at any time.

The system is described in `configuration.nix`, my user environment in `home.nix`, and the dotfiles I care about live in `dotfiles/`. It is public so I can keep it safe and anyone curious is welcome to look around, but it is not meant as a template or a guide.

## Stack

| Component | Choice |
|---|---|
| OS | NixOS 26.05 (stable, no flakes) |
| Compositor | [niri](https://github.com/YaLTeR/niri), a scrollable-tiling Wayland compositor |
| Shell | [DankMaterialShell](https://danklinux.com) for bar, launcher, notifications and lock screen |
| Login | dms-greeter (greetd) |
| User config | [Home Manager](https://github.com/nix-community/home-manager) as a NixOS module |
| Terminal | Alacritty with JetBrainsMono Nerd Font |
| CLI shell | fish with fastfetch on startup |
| Cursor | Bibata |
| Bootloader | systemd-boot, limited to 5 generations |
| Filesystem | ext4 with zram swap |
| Audio | PipeWire (ALSA, PulseAudio, 32-bit support) |
| Browser | [Zen](https://zen-browser.app) via Flatpak |

## What's inside

**System**
- niri and DankMaterialShell from nixpkgs, with the DMS greeter instead of a TTY login
- AMD graphics with 32-bit support and redistributable firmware
- Steam with gamescope, gamemode, MangoHud and Proton-GE
- Flatpak, PipeWire with rtkit, dconf and gvfs
- zram swap, store optimisation and a weekly garbage collection that removes generations older than 14 days

**User environment**
- niri config split into small modules, with the DMS-managed files included last
- fish, Alacritty and niri configured declaratively through Home Manager
- Dotfiles are read-only symlinks into the Nix store, so I edit them in `dotfiles/` and rebuild

## Keybinds

`Mod` is the Super key. The full list is in [`dotfiles/niri/modules/keybinds.kdl`](dotfiles/niri/modules/keybinds.kdl).

| Key | Action |
|---|---|
| `Mod + Return` | Terminal (Alacritty) |
| `Mod + B` | Browser (Zen) |
| `Mod + E` | File manager (Nautilus) |
| `Mod + Ctrl + Return` | App launcher |
| `Mod + Shift + S` | DMS settings |
| `Mod + Alt + L` | Lock screen |
| `Mod + Q` | Close window |
| `Mod + T` | Toggle floating |
| `Mod + A / D` | Focus column left / right |
| `Mod + W / S` | Focus window up / down |
| `Mod + 1-9` | Switch workspace |
| `Mod + Shift + Escape` | Hotkey overlay with all binds |

## Notes to self

- `~/.config/niri/dms/` is written by DMS at runtime and stays outside of Nix. The wallpaper, theme and display settings chosen in DMS are not part of this repo.
- Zen is installed manually as a Flatpak: `flatpak install flathub app.zen_browser.zen`.
- `hardware-configuration.nix` belongs to the machine it was generated on.
- Home Manager is fetched from the `release-26.05` branch without a pinned hash.
- No secrets in this repo, since it is public.
- Flakes are on the list for later, once I am more comfortable with Nix.

## Credits

- [NixOS](https://nixos.org) and [nixpkgs](https://github.com/NixOS/nixpkgs)
- [niri](https://github.com/YaLTeR/niri)
- [DankMaterialShell](https://github.com/AvengeMedia/DankMaterialShell)
- [Home Manager](https://github.com/nix-community/home-manager)
