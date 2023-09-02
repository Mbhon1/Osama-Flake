<p align="center">Welcome to Mbhon1 Flakes ❄️</p>

# Installation

## Pre-requisition

1. NixOS installed and running
2. Flakes enabled

> [!warning] Note: Don't copy the nixos directory as the configs are suited for my personal computer especially the `hardware.nix` file.

- `git clone https://github.com/Mbhon1/nixOS-dots.git`
- `cd nixOS-dots`
- `cp -r ags $HOME/.config`
- `cp -r desk hyprland packages terminal utils *.nix $HOME/.config/home-manager`

In the `flake.nix` and `home.nix` change my username to the one you use on your computer, double check to avoid any errors before running the below commands.

- `sudo nixos-rebuild switch --flake .#yourUsername` to apply system configs.
- `home-manager switch --flake .#yourUsername@hostname` to apply home-manager configs.

# Packages

Who doesn't like flatpak? I use flatpaks for a few apps that work out the box like OBS-Studio and Whatsapp to name a few. Search their [website](https://flathub.org) for apps and how to run them, I'm just showing how to install/activate flatpak on nixOS.

1. `flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo`

2. An example of how to add  apps via flatpak `flatpak install flathub com.valvesoftware.Steam`

# Acknowledgements

Big s/o to these guys dots, they really helped me setup my own little nixOS environment. I drew a lot of inspiration and borrowed a few lines of code, thank you guys!

- [Redyf](https://github.com/Redyf/nixdots)
- [Misterio77](https://github.com/Misterio77/nix-starter-configs.git) 
- [Syndrizzle](https://github.com/syndrizzle/hotfiles) 
- [Aylur](https://github.com/aylur/dotfiles) 
- [TheLinuxPirate](https://github.com/thelinuxpirate/dotfiles.git)
- [LinuxMobile](https://github.com/linuxmobile/kaku.git)
- [Skbolton](https://github.com/skbolton/nix-dotfiles.git)

# TODO

-[ ] Make a script for easy installation for other users.
-[ ] Migrate the rest of my arch dotfiles to .nix. 
-[ ] Fix steam and integrate with .nix.
