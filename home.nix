{ config, pkgs, ... }:

let 
    swaybarCommand = "while echo \"bat: $(cat /sys/class/power_supply/BAT0/capacity)% / bri: $(brightnessctl | grep % | cut -d'(' -f2 | cut -d')' -f1) / vol: $(pamixer --get-volume-human) / $(date +'%F %T')\"; do sleep 0.01; done";
    bemenuCommand = "bemenu-run -p '' -b --fn \"JetBrainsMono Nerd Font Semibold 12\" --tb \"#000000\" --tf \"#FFFFFF\" --fb \"#000000\" --ff \"#FFFFFF\" --nb \"#000000\" --nf \"#666666\" --hb \"#000000\" --hf \"#FFFFFF\" --sb \"#000000\" --hf \"#FFFFFF\"";
in

{
  home.username = "archisman";
  home.homeDirectory = "/home/archisman";

  programs.git = {
    enable = true;
    userName = "DeviousCilantro";
    userEmail = "archisman@mailbox.org";
  };

  programs.foot = {
    enable = true;
    settings = {
      main = {
        term = "xterm-256color";
        font = "JetBrainsMono Nerd Font:size=7.5:style=Semibold";
        dpi-aware = "yes";
      };
      mouse = {
        hide-when-typing = "yes";
      };
      colors = {
        alpha = 0.8;
        foreground = "ffffff";
        background = "000000";
      };
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraConfig = ''
      set nocompatible
      filetype on
      filetype plugin on
      filetype indent on
      syntax enable
      set number
      colorscheme elflord
      set nohlsearch
      set shiftwidth=2
      set tabstop=2
      set expandtab
      set nobackup
      set scrolloff=10
      set wrap
      set incsearch
      set ignorecase
      set smartcase
      set showcmd
      set showmode
      set showmatch
      set history=1000
      set wildmenu
      set wildmode=list:longest
      set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
      set statusline=
      set statusline+=%#LineNr#
      set statusline+=\ %F\ %M\ %Y\ %R
      set statusline+=%=
      set statusline+=\ %p%%
      set laststatus=2
      filetype plugin indent on
      packloadall
      silent! helptags ALL
      let g:ale_linters = {'rust': ['analyzer']}
      inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
    '';
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    autocd = true;
    defaultKeymap = "viins";
    shellAliases = {
        vi = "nvim";
        suvi = "doas nvim";
        vpsup="nmcli connection up vps";
        vpsdown="nmcli connection down vps";
        update = "doas nixos-rebuild switch";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "lambda";
    };
    profileExtra = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
        exec sway --unsupported-gpu &>/dev/null
      fi
      export XDG_DATA_DIRS=$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share
    '';
  };

  services.dunst = {
    enable = true;
    settings = {
      global = {
        width = "(0, 1500)";
        height = 300;
        offset = "10x50";
        origin = "top-right";
        transparency = 0;
        frame_color = "#282828";
        font = "JetBrainsMono Nerd Font Semibold 12";
      };
      urgency_normal = {
        background = "#000000";
        foreground = "#ffffff";
        timeout = 2;
      };
      urgency_low = {
        background = "#000000";
        foreground = "#ffffff";
        timeout = 2;
      };
      urgency_critical = {
        background = "#000000";
        foreground = "#ffffff";
        timeout = 2;
      };
    };
  };

  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      terminal = "foot";
      modifier = "Mod1";
      menu = bemenuCommand;
      output = {
        "*" = {
          bg = "#000000 solid_color";
        };
      };
      input = {
        "type:touchpad"= {
          dwt = "enabled";
          tap = "enabled";
          natural_scroll = "enabled";
          middle_emulation = "enabled";
          pointer_accel = "0.1";
        };
      };
      colors = {
        focused = {
          border = "#666666";
          background = "#666666";
          text = "#F8F8F2";
          indicator = "#666666";
          childBorder =  "#666666";
        };
        focusedInactive = {
          border = "#44475A";
          background = "#44475A";
          text = "#F8F8F2";
          indicator = "#44475A";
          childBorder =  "#44475A";
        };
        unfocused = {
          border = "#282A36";
          background = "#282A36";
          text = "#BFBFBF";
          indicator = "#282A36";
          childBorder =  "#282A36";
        };
        urgent = {
          border = "#44475A";
          background = "#FF5555";
          text = "#F8F8F2";
          indicator = "#FF5555";
          childBorder =  "#FF5555";
        };
        placeholder = {
          border = "#282A36";
          background = "#282A36";
          text = "#F8F8F2";
          indicator = "#282A36";
          childBorder =  "#282A36";
        };
        background = "#F8F8F2";
      };
      defaultWorkspace = "workspace 1";
      workspaceAutoBackAndForth = true;
      focus.followMouse = "no";
      window = {
        border = 5;
        hideEdgeBorders = "smart";
      };
      seat = { "*" = { hide_cursor = "when-typing enable"; }; };
      startup = [
        { command = "autotiling-rs"; }
        { command = "wl-paste -t text --watch clipman store --no-persist"; }
        { command = "brightnessctl --device=asus::kbd_backlight s 3+"; }
      ];
      modes = {
        resize = {
        Escape = "mode default";
        h = "resize shrink width 10 px";
        j = "resize grow height 10 px";
        k = "resize shrink height 10 px";
        l = "resize grow width 10 px";
        };
      };
      bars = [
        {
          position = "top";
          statusCommand = swaybarCommand;
          fonts = {
            names = [ "JetBrainsMono Nerd Font" ];
            style = "Semibold";
            size = 12.0;
          };
          colors = {
            statusline = "#ffffff";
            background = "00000000";
            focusedWorkspace = {
              border = "00000000";
              background = "00000000";
              text = "#ffffff";
            };
            activeWorkspace = {
              border = "00000000";
              background = "00000000";
              text = "#ffffff";
            };
            inactiveWorkspace = {
              border = "00000000";
              background = "00000000";
              text = "#424242";
            };
          };
        }
      ];
      keybindings = {
          "Mod1+Return" = "exec foot";
          "Mod1+Shift+q" = "kill";
          "Mod1+d" = "exec ${menu}";
          "Mod1+Shift+c" = "reload";
          "Mod1+Shift+e" = "exec 'swaymsg exit'";
          "Mod1+f" = "fullscreen";
          "Mod1+Tab" = "workspace next";
          "Mod1+Shift+Tab" = "workspace prev";
          "F1" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.01-";
          "XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.01+";
          "XF86AudioMicMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle && exec wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 27%";
          "F2" = "exec brightnessctl --device=\"asus::kbd_backlight\" s 1-";
          "F3" = "exec brightnessctl --device=\"asus::kbd_backlight\" s 1+";
          "Mod1+F2" = "exec asusctl led-mode -p";
          "Mod1+F3" = "exec asusctl led-mode -n";
          "F7" = "exec brightnessctl s 1%-";
          "F8" = "exec brightnessctl s 1%+";
          "F5" = "exec playerctl play-pause";
          "F4" = "exec playerctl previous";
          "F6" = "exec playerctl next";
          "Mod1+Shift+f" = "exec firefox";
          "Mod1+t" = "exec thunderbird";
          "Mod1+z" = "exec zathura";
          "F11" = "exec swaylock -f -c 000000 && systemctl suspend";
          "Print" = "exec grim -g \"$(slurp)\" $(date +'%F_%T.png')";
          "Mod1+h" = "focus left";
          "Mod1+j" = "focus down";
          "Mod1+k" = "focus up";
          "Mod1+l" = "focus right";
          "Mod1+Shift+h" = "move left";
          "Mod1+Shift+j" = "move down";
          "Mod1+Shift+k" = "move up";
          "Mod1+Shift+l" = "move right";
          "Mod1+c" = "splith";
          "Mod1+v" = "splitv";
          "Mod1+space" = "floating toggle";
          "Mod1+1" = "workspace 1";
          "Mod1+2" = "workspace 2";
          "Mod1+3" = "workspace 3";
          "Mod1+4" = "workspace 4";
          "Mod1+5" = "workspace 5";
          "Mod1+6" = "workspace 6";
          "Mod1+7" = "workspace 7";
          "Mod1+8" = "workspace 8";
          "Mod1+9" = "workspace 9";
          "Mod1+0" = "workspace 10";
          "Mod1+Shift+1" = "move workspace 1";
          "Mod1+Shift+2" = "move workspace 2";
          "Mod1+Shift+3" = "move workspace 3";
          "Mod1+Shift+4" = "move workspace 4";
          "Mod1+Shift+5" = "move workspace 5";
          "Mod1+Shift+6" = "move workspace 6";
          "Mod1+Shift+7" = "move workspace 7";
          "Mod1+Shift+8" = "move workspace 8";
          "Mod1+Shift+9" = "move workspace 9";
          "Mod1+Shift+0" = "move workspace 10";
          "Mod1+Shift+grave" = "move scratchpad";
          "Mod1+grave" = "scratchpad show";
          "Mod1+r" = "mode resize";
      };
    };
  };

  home.stateVersion = "22.11";
  programs.home-manager.enable = true;
}
