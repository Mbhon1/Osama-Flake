# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # <home-manager/nixos>
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.configurationLimit = lib.mkDefault 10;
  boot.extraModprobeConfig = "options kvm_intel nested=1";

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Africa/Johannesburg";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_ZA.UTF-8";

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
    enable = true;
    displayManager = {
      defaultSession = "hyprland";
      gdm = {
        enable = true;
	wayland = true;
      };
    };
  };

  services = {
    gvfs.enable = true; # Mount, trash, and other functionalities
    tumbler.enable = true; # Thumbnail support for images
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mbhon1 = {
    isNormalUser = true;
    description = "Mbhon1";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };

  # home-manager = {
  #  useGlobalPkgs = true;
  #  useUserPackages = true;
  #  users.mbhon1 = import ./home.nix;
  # };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = lib.mkForce true;
  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 1w";
  };
  nix.settings = {
    auto-optimise-store = true;
    builders-use-substitutes = true;
    experimental-features = [ "nix-command" "flakes" ];
  };

  nixpkgs.overlays = [
   (self: super: {
     fcitx-engines = pkgs.fcitx5;
   })
   (final: prev: {
     steam = prev.steam.override ({ extraPkgs ? pkgs': [], ... }: {
       extraPkgs = pkgs': (extraPkgs pkgs') ++ (with pkgs'; [
         libgdiplus
       ]);
     });
   })
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    home-manager
    steam-run
    wineWowPackages.stable
  ];
  
  environment.shells = with pkgs; [ bash zsh ];
  # environment.variables.EDITOR = "nvim";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
  #  enableSSHSupport = true;
  #  PermitRootLogin = "prohibit-password";
  #  PasswordAuthentication = false;
  };

  programs.zsh.enable = true;
  programs.hyprland.enable = true;
  programs = {
    adb.enable = true;
    ssh.startAgent = true;
    dconf.enable = true;
  };
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.settings = {
    X11Forwarding = true;
  };
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  services = {
    flatpak.enable = true;
    dbus.packages = [ pkgs.gcr ];
    udev.packages = with pkgs; [
      gnome.gnome-settings-daemon
    ];
  };

  sound.enable = lib.mkForce false;
  hardware.pulseaudio.enable = false;

  security.polkit.enable = true;
  security.rtkit.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
     xdg-desktop-portal-gtk
   ];
  };

  virtualisation.libvirtd = {
    enable = true;
    # qemu.runAsRoot = true;
  };

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
	ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
	Restart = "on-failure";
	RestartSec = 1;
	TimeoutStopSec = 10;
      };
    };
    extraConfig = ''
      DefaultTimeoutStopSec=10s
    '';
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}