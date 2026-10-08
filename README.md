<div align="center">

<img src="https://raw.githubusercontent.com/NixOS/nixos-artwork/master/logo/nix-snowflake-colours.svg" width="110" alt="Nix logo" />

# nix-config

My personal NixOS desktop: niri, DankMaterialShell and a gaming-ready AMD setup.

<br />

[![NixOS](https://img.shields.io/badge/NixOS-26.05_stable-5277C3?style=for-the-badge&logo=nixos&logoColor=white&labelColor=1a1b26)](https://nixos.org)
[![Wayland](https://img.shields.io/badge/Wayland-niri-7EBAE4?style=for-the-badge&logo=wayland&logoColor=white&labelColor=1a1b26)](https://github.com/YaLTeR/niri)
[![Shell](https://img.shields.io/badge/Shell-DankMaterialShell-9D7CD8?style=for-the-badge&labelColor=1a1b26)](https://danklinux.com)

<br />

[Principles](#-principles) · [What's inside](#-whats-inside) · [Keybinds](#-keybinds) · [Bootstrap](#-bootstrap) · [Roadmap](#-roadmap)

</div>

## ❯ Principles

- **Declarative first.** If it can live in Nix, it lives in Nix. Packages, services, dotfiles, default apps and even my home folders come from this repo.
- **Runtime state stays out.** Whatever DankMaterialShell writes while running (colors, outputs, wallpaper) stays in a mutable folder and is never forced into the store.
- **No bloat.** Every package is in the config because I put it there, and I know why.

## ❯ What's inside

<details>
<summary><b>Desktop</b></summary>

<br />

- **niri** as the compositor, with **xwayland-satellite** for X11 apps like Steam
- **DankMaterialShell** with system monitoring, dynamic theming, audio wavelength and calendar events, running as a systemd user service
- **dms-greeter** on greetd instead of a TTY login
- `NIXOS_OZONE_WL=1` so Electron apps render natively on Wayland

</details>

<details>
<summary><b>Gaming</b></summary>

<br />

- **Steam** with a gamescope session and **Proton-GE** as an extra compat tool
- **GameMode**, with my user in the `gamemode` group so it can set the CPU governor
- **gamescope**, **MangoHud** and **MangoJuice**
- **Heroic** for Epic and GOG, **Prism Launcher** for Minecraft

</details>

<details>
<summary><b>Apps</b></summary>

<br />

| Purpose | App |
|---|---|
| Terminal | Alacritty |
| Files | Nautilus, with video thumbnails via ffmpegthumbnailer |
| Images | Loupe |
| Video | Celluloid |
| PDF | Papers |
| Editor | VSCodium |
| Audio | pwvucontrol, EasyEffects |
| Browser | Zen (Flatpak) |
| Git | git, gh |

</details>

<details>
<summary><b>Home Manager</b></summary>

<br />

- Dotfiles from `dotfiles/` are linked into `~/.config` as read-only store symlinks
- XDG user directories are created and registered, so Nautilus knows Downloads, Pictures and the rest
- Default apps for images, videos, PDFs and folders are pinned through `xdg.mimeApps`

</details>

<details>
<summary><b>System & housekeeping</b></summary>

<br />

- systemd-boot, capped at 5 generations
- ext4 with zram swap and weekly TRIM
- NetworkManager, PipeWire with rtkit, Flatpak, dconf and gvfs
- English UI with German formats and a German keyboard layout
- Automatic store optimisation and a weekly garbage collection that drops generations older than 14 days

</details>

## ❯ Keybinds

`Mod` is the Super key. The full list lives in [`dotfiles/niri/modules/keybinds.kdl`](dotfiles/niri/modules/keybinds.kdl).

| Key | Action | | Key | Action |
|---|---|---|---|---|
| `Mod` `Return` | Terminal | | `Mod` `A` / `D` | Focus column left / right |
| `Mod` `B` | Browser | | `Mod` `W` / `S` | Focus window up / down |
| `Mod` `E` | Files | | `Mod` `1`–`9` | Switch workspace |
| `Mod` `Ctrl` `Return` | Launcher | | `Mod` `T` | Toggle floating |
| `Mod` `Shift` `S` | DMS settings | | `Mod` `Q` | Close window |
| `Mod` `Alt` `L` | Lock screen | | `Mod` `Shift` `Esc` | Hotkey overlay |

## ❯ Bootstrap

How I bring this config onto a fresh machine.

**1.** Install NixOS 26.05 with the graphical installer and choose *No desktop*.

**2.** Add the Home Manager channel:

```sh
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-26.05.tar.gz home-manager
sudo nix-channel --update
```

**3.** Swap in this repo, but keep the hardware config the installer generated:

```sh
sudo mv /etc/nixos /etc/nixos.installer
sudo nix-shell -p git --run "git clone https://github.com/damian1607/nix-config.git /etc/nixos"
sudo cp /etc/nixos.installer/hardware-configuration.nix /etc/nixos/
```

**4.** Build and reboot:

```sh
sudo nixos-rebuild switch
```

**5.** The few things that stay manual:

```sh
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install flathub app.zen_browser.zen
sudo gh auth login    # so I can push from /etc/nixos
```

After that I set wallpaper, monitors and cursor in the DMS settings.

### Daily loop

```sh
sudo nixos-rebuild switch              # apply changes
sudo nixos-rebuild switch --upgrade    # update channels, then apply
sudo git add -A && sudo git commit -m "..." && sudo git push
```

## ❯ Roadmap

- [ ] Zen as native nix-pkg
- [ ] Move to flakes

## ❯ Credits

[NixOS](https://nixos.org) · [nixpkgs](https://github.com/NixOS/nixpkgs) · [niri](https://github.com/YaLTeR/niri) · [DankMaterialShell](https://github.com/AvengeMedia/DankMaterialShell) · [Home Manager](https://github.com/nix-community/home-manager)
