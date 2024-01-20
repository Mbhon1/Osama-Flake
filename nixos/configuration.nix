{ config, pkgs, lib, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  boot = {
    loader.grub = {
      enable = true;
      device = "/dev/sda";
      useOSProber = true;
      configurationLimit = lib.mkDefault 5;
    };
    extraModprobeConfig = "options kvm_intel nested=1";
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    firewall = rec {
      allowedTCPPortRanges = [
          { from = 1714; to = 1764; }
	];
      allowedUDPPortRanges = allowedTCPPortRanges;
      # allowedTCPPorts = [ ... ];
      # allowedUDPPorts = [ ... ];
      # enable = false;
    };
    # wireless.enable = true;
    # proxy = {
      # default = "http://user:password@proxy:port/";
      # noProxy = "127.0.0.1,localhost,internal.domain";
    # };
  }; 

  time.timeZone = "Africa/Johannesburg";
  i18n.defaultLocale = "en_GB.UTF-8";

  services = { 
    xserver = {
      layout = "us";
      xkbVariant = "";
      enable = true;
      displayManager = {
        # defaultSession = "gnome";
        gdm = {
          enable = true;
        };
      };
    };
    gvfs.enable = true;
    tumbler.enable = true;
    openssh = {
      enable = true;
      settings.X11Forwarding = true;
    };
    pipewire = {
      enable = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };
    flatpak.enable = true;
    dbus.packages = [ pkgs.gcr ];
    udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
    gnome.gnome-keyring.enable = true;
  };
  
  users.users.mbhon1 = {
    isNormalUser = true;
    description = "Mbhon1";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };

  nixpkgs = {
    config = {
     allowUnfree = lib.mkForce true;
     permittedInsecurePackages = [ 
     	"electron-19.1.9"
	"mailspring-1.11.0"
     ];
    };
    overlays = [
      (self: super: {
        fcitx-engines = pkgs.fctix5;
      })
    ];
  };

  nix = { 
    gc = {
      automatic = lib.mkDefault true;
      dates = lib.mkDefault "weekly";
      options = lib.mkDefault "--delete-older-than 1w";
    };
    settings = {
      auto-optimise-store = true;
      builders-use-substitutes = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
  };
  
  environment = {
    systemPackages = with pkgs; [
      home-manager
      git
      virt-manager
      virt-viewer
      etcher
      mailspring
    ];
    shells = with pkgs; [ bash zsh ];
    variables.EDITOR = "nvim";
    etc = {
      "pipewire/pipewire.conf.d/92-low-latency.conf".text = ''
        context.properties = {
          default.clock.rate = 44100
	  default.clock.quantum = 512
	  default.clock.max-quuantum = 512
        };
      '';
    };
  };

  programs = {
   adb.enable = true;
   ssh.startAgent = true;
   dconf.enable = true;
   zsh.enable = true;
   seahorse.enable = true;
   steam = {
     enable = true;
     remotePlay.openFirewall = true;
     dedicatedServer.openFirewall = true;
   };
   gnupg.agent = {
     enable = true;
     # enableSSHSupport = true;
   };
   hyprland = {
     enable = true;
     # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
     xwayland.enable = true;
     # enableNvidiaPatches = true;
   };
  };

  sound.enable = true;
  hardware.pulseaudio.enable = false;

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  };

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu.runAsRoot = true;
        extraConfig = ''
        unix_sock_group = "libvirtd"
        unix_sock_rw_perms = "0770"
      '';
    };
    virtualbox = {
      host = {
        enable= true;
        enableExtensionPack = true;
      };
      guest = {
        enable = true;
	      x11 = true;
      };
    };
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

  system.stateVersion = "23.05"; 
}
