{ config, pkgs, lib, ... }:

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
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
    };
  };

  environment = { 
    systemPackages = with pkgs; [
      autotiling-rs
      bemenu
      brightnessctl
      btop
      cargo
      chromium
      clipman
      cryptsetup
      doas
      dracula-theme
      dunst
      element-desktop
      feh
      firefox-wayland
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
      oh-my-zsh
      openjdk19
      pamixer
      parted
      pass-wayland
      passExtensions.pass-import
      pavucontrol
      pinentry
      playerctl
      plex-media-player
      powertop
      pwgen
      rsync
      rustc
      sabnzbd
      slurp
      spotify
      sway
      swayidle
      swaylock
      thunderbird
      tlp
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

  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };

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
    tlp.enable = true;
    dbus.enable = true;
    xserver.videoDrivers = [ "nvidia" ];
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

  nixpkgs.config.allowUnfree = true;

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

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
