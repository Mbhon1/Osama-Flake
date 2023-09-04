{ config, pkgs, lib, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # <home-manager/nixos>
    ];

  boot = {
    loader.grub = {
      enable = true;
      device = "/dev/sda";
      useOSProber = true;
      configurationLimit = lib.mkDefault 10;
    };
    extraModprobeConfig = "options kvm_intel nested=1";
  };

  networking.hostName = "nixos"; 
  # networking.wireless.enable = true;  

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  networking.networkmanager.enable = true;

  time.timeZone = "Africa/Johannesburg";

  i18n.defaultLocale = "en_ZA.UTF-8";

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
    gvfs.enable = true; 
    tumbler.enable = true; 
  };

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
   #(final: prev: {
   #  steam = prev.steam.override ({ extraPkgs ? pkgs': [], ... }: {
   #    extraPkgs = pkgs': (extraPkgs pkgs') ++ (with pkgs'; [
   #      libgdiplus
   #    ]);
   #  });
   #})
  ];

  environment.systemPackages = with pkgs; [
    home-manager
    # steam-run
    wineWowPackages.stable
    virt-manager
    libsecret
    qemu_full
    qemu_kvm
  ];

  environment.shells = with pkgs; [ bash zsh ];
  environment.variables.EDITOR = "nvim";

  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
  #  enableSSHSupport = true;
  #  PermitRootLogin = "prohibit-password";
  #  PasswordAuthentication = false;
  };
  programs.seahorse.enable = true;

  programs.zsh.enable = true;
  programs.hyprland.enable = true;
  programs = {
    adb.enable = true;
    ssh.startAgent = true;
    dconf = {
      enable = true;
      };
  };
  # programs.steam = {
     # enable = true;
     # remotePlay.openFirewall = true;
     # dedicatedServer.openFirewall = true;
  # };


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
  services.gnome.gnome-keyring.enable = true;

  sound.enable = lib.mkForce false;
  # hardware.pulseaudio.enable = false;

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
    qemu.runAsRoot = true;
    #qemu.package = [
     # pkgs.qemu_kvm
      #pkgs.qemu_full
    #];
    extraConfig = ''
      unix_sock_group = "libvirtd"
      unix_sock_rw_perms = "0770"
      '';
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

  system.stateVersion = "23.05"; 

}
