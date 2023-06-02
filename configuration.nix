{ config, pkgs, lib, ... }:

let
  my-python-packages = ps: with ps; [
    numpy
  ];
in

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  nix.nixPath =
    [
      "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
      "nixos-config=/persist/etc/nixos/configuration.nix"
      "/nix/var/nix/profiles/per-user/root/channels"
    ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd.postDeviceCommands = lib.mkAfter ''
      zfs rollback -r rpool/encrypted/local/root@blank
    '';
    kernelParams = [ "elevator=none" ];
  };

  networking = {
    hostId = "10704779";
    hostName = "laptop";
    networkmanager.enable = true;
    firewall = {
      enable = false;
      checkReversePath = false;
    };
  };

  hardware = {
    bluetooth.enable = true;
    pulseaudio.enable = false;
    opengl = {
      enable = true;
      driSupport = true;
    };
    enableRedistributableFirmware = true;
  };

  environment = { 
    systemPackages = with pkgs; [
      autoconf
      autotiling-rs
      bemenu
      brightnessctl
      btop
      cargo
      clippy
      cmus
      cryptsetup
      doas
      dunst
      easytag
      element-desktop
      feh
      firefox-wayland
      flac
      foot
      gcc
      git
      gnome3.adwaita-icon-theme
      gnupg
      go
      grim
      htop
      mpv
      neofetch
      neovim
      obs-studio
      oh-my-zsh
      om4
      parted
      pass-wayland
      passExtensions.pass-import
      pavucontrol
      playerctl
      powertop
      pwgen
      rsync
      rustc
      rust-analyzer
      signal-desktop
      slurp
      sway
      swayidle
      swaylock
      thunderbird
      tigervnc
      unzip
      wget
      wireguard-tools
      wl-clipboard
      zathura
      zsh
      zsh-autosuggestions
      zsh-syntax-highlighting
    ];
    persistence."/persist" = {
      directories = [
        "/etc/nixos"
        "/etc/NetworkManager"
        "/etc/modprobe.d"
      ];
    };
    binsh = "${pkgs.dash}/bin/dash";
    sessionVariables = {
      MOZ_ENABLE_WAYLAND = "1";
      XDG_CURRENT_DESKTOP = "sway"; 
      GTK_THEME = "Adwaita:dark";
    };
    pathsToLink = [ "/share/zsh" ];
  };
   
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    noto-fonts
    noto-fonts-cjk
  ];

  services = {
    zfs = {
      autoScrub.enable = true;
      autoSnapshot.enable = true;
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    openssh.enable = false;
    dbus.enable = true;
    logind.lidSwitch = "ignore";
  };


  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_US.UTF-8";

  programs = {
    sway.enable = true;
    zsh.enable = true;
  };

  users = {
    defaultUserShell = pkgs.zsh;
    mutableUsers = false;
    users = {
      root = {
        initialHashedPassword = "\$6\$zAjyq6eGWNx2Gkc0\$niEesi37PrAacsn7.lee2WOYF7GMGI6y3rwsgPd2IqANqsC/rFIojGLj.Qncc6frzboFyhG6GEl/GEkk7f9xy0";
      };

      archisman = {
        isNormalUser = true;
        createHome = true;
        initialHashedPassword = "\$6\$yZm2shp6XSRMWUlm\$KiQ6p7km4IdwRE.btTQPI30QkCGwbQPJel46jwmSdyj5stRsCP2RVC73wL5NY8qLg0HMeTHDQ.Hze0MjmpAhA0";
	    extraGroups = [ "wheel" "networkmanager" ];
	    uid = 1000;
	    home = "/home/archisman";
	    useDefaultShell = true;
      };
    };
  };

  security = {
    doas.enable = true;
    sudo.enable = false;
    doas.extraRules = [{
      users = [ "archisman" ];
      keepEnv = true;
      noPass = true;
    }];
    rtkit.enable = true;
    polkit.enable = true;
  };

  system = {
    stateVersion = "unstable";
    autoUpgrade.enable = true;
  };

  systemd = {
    services = {
      NetworkManager-wait-online.enable = false;
    };
  };

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
  };

  powerManagement = {
    enable = true;
    powertop.enable = true;
    cpuFreqGovernor = "schedutil";
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };

}
