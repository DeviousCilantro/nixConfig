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
    kernelPatches = [
      {
        name = "Fix keyboard issue";
        patch = ./keyboard.patch;
      }
    ];
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "amdgpu.dcdebugmask=0x10" ];
  };

  boot.initrd.postDeviceCommands = lib.mkAfter ''
    zfs rollback -r rpool/encrypted/local/root@blank
  '';

  networking = {
    hostId = "0eedebe6";
    hostName = "nixos";
    networkmanager.enable = true;
    firewall = {
      enable = false;
      checkReversePath = false;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      autoconf
      autotiling-rs
      bemenu
      brightnessctl
      btop
      cmus
      cryptsetup
      dmenu-rs
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
      gnome.gnome-terminal
      gnupg
      go
      grim
      htop
      mpv
      nasm
      neofetch
      neovim
      nodejs_20
      obs-studio
      oh-my-zsh
      om4
      openssl
      pango
      parted
      pass-wayland
      passExtensions.pass-import
      pavucontrol
      pciutils
      pkgconfig
      playerctl
      powertop
      pwgen
      rsync
      rustup
      rust-analyzer
      signal-desktop
      slurp
      sway
      swayidle
      swaylock
      thunderbird
      tigervnc
      unzip
      wezterm
      wget
      wireguard-tools
      wl-clipboard
      xorg.libxcb
      xorg.libX11
      xorg.xmodmap
      yarn
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
    sessionVariables = {
      #DRI_PRIME = "1";
      GTK_THEME = "Adwaita:dark";
    };
    pathsToLink = [ "/share/zsh" ];
  };

  fonts.fonts = with pkgs;
    [
     (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
    ];

  time.timeZone = "Asia/Kolkata";

  i18n.defaultLocale = "en_US.UTF-8";

  programs = {
    sway.enable = true;
    zsh.enable = true;
  };

  hardware = {
    pulseaudio.enable = false;
    opengl = {
      enable = true;
      driSupport = true;
    };
    enableRedistributableFirmware = true;
    firmware = [
      (pkgs.stdenvNoCC.mkDerivation {
        name = "amdgpu-firmware";
        buildCommand = ''
          dir="$out/lib/firmware"
          mkdir -p "$dir"
	        cp -r ${./firmware}/* "$dir"
        '';
      })
    ];
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
    dbus.enable = true;
    logind.lidSwitch = "ignore";
    fwupd.enable = true;
  };

  users = {
    defaultUserShell = pkgs.zsh;
    mutableUsers = false;
    users = {
      root = {
        initialHashedPassword = "\$6\$dY7OmD3bWJdqojlJ\$.uvGugs/7ym9pZUOuJPBDBT.AEnsDA02psowaWRAYFwzJFDEVRwE9MGYV.dJOZcByWwmPqyjukbtg4ySRoGmf/";
      };

      archisman = {
        isNormalUser = true;
        createHome = true;
        initialHashedPassword = "\$6\$kWDMWmDB.muf76rU\$o0lVGmABk2GIz08bU9WWd5/BHM3KIJ0m6yQKFQq.n7AODqreySS34JIqNEO7tLx50DD9CROOAi4DS1hpxYUEm/";
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

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
  };

  systemd.services = {
    i2c_unbind = {
      script = ''
        /run/current-system/sw/bin/sh -c "echo AMDI0010:01 > /sys/bus/platform/drivers/i2c_designware/unbind"
      '';
      wantedBy = [ "multi-user.target" ];
    };
    NetworkManager-wait-online.enable = false;
  };

  powerManagement = {
    enable = true;
    powertop.enable = true;
    cpuFreqGovernor = "schedutil";
  };

  services.udev.extraRules = ''
    KERNEL=="card0", SUBSYSTEM=="drm", DRIVERS=="amdgpu", ATTR{device/power_dpm_force_performance_level}="low"
  '';

  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Automatic Garbage Collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

}
