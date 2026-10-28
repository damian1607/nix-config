<div align="center">

<img src="https://raw.githubusercontent.com/NixOS/nixos-artwork/master/logo/nix-snowflake-colours.svg" width="110" alt="Nix logo" />

## nix-config

</div>

### What's inside

- niri as the compositor
- noctalia as bar, launcher, lock screen and wallpaper-based theming
- noctalia-greeter on greetd
- dotfiles from `dotfiles/` are linked into `~/.config` as read-only symlinks
- neovim with catppuccin, lualine and treesitter


### Keybinds

`Mod` is the Super key. The full list lives in [`dotfiles/niri/modules/keybinds.kdl`](dotfiles/niri/modules/keybinds.kdl).

| Key | Action | | Key | Action |
|---|---|---|---|---|
| `Mod` `Return` | Terminal | | `Mod` `A` / `D` | Focus column left / right |
| `Mod` `B` | Browser | | `Mod` `W` / `S` | Focus window up / down |
| `Mod` `E` | Files | | `Mod` `1`–`9` | Switch workspace |
| `Mod` `Ctrl` `Return` | Launcher | | `Mod` `T` | Toggle floating |
| `Mod` `Shift` `S` | Noctalia settings | | `Mod` `Q` | Close window |
| `Mod` `L` | Lock screen | | `Mod` `Shift` `Esc` | Hotkey overlay |

### Installation

**1.** Install NixOS with the graphical installer choosing *No desktop* and naming the user *damian*.

**2.** Swap in this repo, but keep the hardware config the installer generated:

```sh
sudo mv /etc/nixos /etc/nixos.installer
sudo nix-shell -p git --run "git clone https://github.com/damian1607/nix-config.git /etc/nixos"
sudo cp /etc/nixos.installer/hardware-configuration.nix /etc/nixos/
```

**3.** Build and reboot

```sh
sudo nixos-rebuild switch --flake /etc/nixos#nixos --option experimental-features "nix-command flakes"
```

**4.** Remove old bootloader
```sh
sudo bootctl remove
```

After that I set my wallpaper in the Noctalia settings and customize the bar, launcher, etc.
