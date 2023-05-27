{ config, pkgs, ... }:

let 
    swaybarCommand = "while echo \"bat: $(cat /sys/class/power_supply/BAT0/capacity)% / $(date +'%F %T')\"; do sleep 0.01; done";
    bemenuCommand = "bemenu-run -p '' -b --fn \"JetBrainsMono Nerd Font Semibold 12\" --tb \"#000000\" --tf \"#FFFFFF\" --fb \"#000000\" --ff \"#FFFFFF\" --nb \"#000000\" --nf \"#666666\" --hb \"#000000\" --hf \"#FFFFFF\" --sb \"#000000\" --hf \"#FFFFFF\"";
in

{
  home.username = "archisman";
  home.homeDirectory = "/home/archisman";

  programs = {
    home-manager.enable = true;
    
    firefox = {
      enable = true;
      profiles = {
        profile = {
          extensions = with pkgs.nur.repos.rycee.firefox-addons; [
              ublock-origin
              bitwarden
              darkreader
          ];
          settings = {
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            "datareporting.healthreport.service.enabled" = false;
            "datareporting.healthreport.uploadEnabled" = false;
            "datareporting.policy.dataSubmissionEnabled" = false;
            "browser.ping-centre.telemetry" = false;
            "browser.contentblocking.category" = "strict";
            "browser.onboarding.enabled" = false;
            "toolkit.telemetry.archive.enabled" = false;
            "toolkit.telemetry.bhrPing.enabled" = false;
            "toolkit.telemetry.enabled" = false;
            "toolkit.telemetry.firstShutdownPing.enabled" = false;
            "toolkit.telemetry.newProfilePing.enabled" = false;
            "toolkit.telemetry.reportingpolicy.firstRun" = false;
            "toolkit.telemetry.shutdownPingSender.enabled" = false;
            "toolkit.telemetry.unified" = false;
            "toolkit.telemetry.updatePing.enabled" = false;
            "toolkit.telemetry.cachedClientID" = "";
            "experiments.enabled" = false;
            "experiments.activeExperiment" = false;
            "experiments.supported" = false;
            "network.allow-experiments" = false;
            "extensions.shield-recipe-client.enabled" = false;
            "extensions.shield-recipe-client.user_id" = "";
            "extensions.shield-recipe-client.api_url" = "";
            "extensions.formautofill.creditCards.enabled" = false;
            "dom.forms.autocomplete.formautofill" = false;
            "app.normandy.enabled" = false;
            "app.normandy.api_url" = "";
            "app.shield.optoutstudies.enabled" = false;
            "permissions.default.desktop-notification" = 2;
            "browser.aboutConfig.showWarning" =  false;
            "browser.startup.page" = 0;
            "browser.startup.homepage" = "about:blank";
            "browser.newtabpage.enabled" = false;
            "browser.toolbars.bookmarks.visibility" = "never";
            "browser.newtabpage.activity-stream.showSponsored" = false;
            "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
            "browser.newtabpage.activity-stream.default.sites" = "";
            "intl.accept_languages" = "en-US";
            "javascript.use_us_english_locale" = true;
            "extensions.getAddons.showPane" = false;
            "extensions.htmlaboutaddons.recommendations.enabled" = false;
            "toolkit.telemetry.coverage.opt-out" = true;
            "toolkit.coverage.opt-out" = true;
            "toolkit.coverage.endpoint.base" = "";
            "browser.newtabpage.activity-stream.feeds.telemetry" = false;
            "browser.newtabpage.activity-stream.telemetry" = false;
            "breakpad.reportURL" = "";
            "browser.tabs.crashReporting.sendReport" = false;
            "browser.safebrowsing.downloads.remote.enabled" = false;
            "network.prefetch-next" = false;
            "network.dns.disablePrefetch" = false;
            "network.predictor.enabled" = false;
            "network.predictor.enable-prefetch" = false;
            "network.http.speculative-parallel-limit" = 0;
            "browser.places.speculativeConnect.enabled" = false;
            "network.dns.disableIPv6" = true;
            "browser.urlbar.speculativeConnect.enabled" = false;
            "browser.urlbar.dnsResolveSingleWordsAfterSearch" = 0;
            "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
            "browser.urlbar.suggest.quicksuggest.sponsored" = false;
            "browser.formfill.enable" = false;
            "signon.autofillForms" = false;
            "signon.formlessCapture.enabled" = false;
            "network.auth.subresource-http-auth-allow" = 1;
            "browser.cache.disk.enable" = false;
            "browser.privatebrowsing.forceMediaMemoryCache" = true;
            "media.memory_cache_max_size" = 65536;
            "browser.sessionstore.privacy_level" = 2;
            "toolkit.winRegisterApplicationRestart" = false;
            "browser.shell.shortcutFavicons" = false;
            "security.ssl.require_safe_negotiation" = true;
            "security.tls.enable_0rtt_data" = false;
            "security.OCSP.require" = true;
            "security.cert_pinning.enforcement_level" = 2;
            "security.remote_settings.crlite_filters.enabled" = true;
            "security.pki.crlite_mode" = 2;
            "dom.security.https_only_mode" = true;
            "dom.security.https_only_mode_send_http_background_request" = false;
            "security.ssl.treat_unsafe_negotiation_as_broken" = true;
            "browser.xul.error_pages.expert_bad_cert" = true;
            "privacy.userContext.enabled" = true;
            "privacy.userContext.ui.enabled" = true;
            "media.peerconnection.ice.proxy_only_if_behind_proxy" = true;
            "media.peerconnection.ice.default_address_only" = true;
            "media.eme.enabled" = false;
            "dom.disable_window_move_resize" = true;
            "accessibility.force_disabled" = 1;
            "browser.helperApps.deleteTempFileOnExit" = true;
            "browser.uitour.enabled" = false;
            "network.IDN_show_punycode" = true;
            "browser.download.useDownloadDir" = false;
            "browser.download.alwaysOpenPanel" = false;
            "browser.download.manager.addToRecentDocs" = false;
            "browser.download.always_ask_before_handling_new_types" = true;
            "privacy.sanitize.sanitizeOnShutdown" = true;
            "privacy.clearOnShutdown.cache" = true;
            "privacy.clearOnShutdown.downloads" = true;
            "privacy.clearOnShutdown.formdata" = true;
            "privacy.clearOnShutdown.history" = true;
            "privacy.clearOnShutdown.sessions" = true;
            "privacy.clearOnShutdown.cookies" = true;
            "privacy.clearOnShutdown.offlineApps" = true;
            "privacy.sanitize.timeSpan" = 0;
            "browser.startup.homepage_override.mstone" = "ignore";
            "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
            "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
            "browser.messaging-system.whatsNewPanel.enabled" = false;
            "browser.urlbar.showSearchTerms.enabled" = false;
            "extensions.pocket.enabled" = false;
            "extensions.unifiedExtensions.enabled" = false;
            "keyword.enabled" = true;
          };
          search = {
            engines = {
              "Whoogle" = {
                urls = [{ template = "https://whoogle.zxyno.xyz/search?q={searchTerms}"; }];
              };
              "Nix Packages" = {
                urls = [{
                  template = "https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query={searchTerms}";
                }];

                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@np" ];
              };
              "NixOS Wiki" = {
                urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
                iconUpdateURL = "https://nixos.wiki/favicon.png";
                updateInterval = 24 * 60 * 60 * 1000;
                definedAliases = [ "@nw" ];
              };
            };
            force = true;
            default = "Whoogle";
          };
          userChrome =
          ''
            #navigator-toolbox { font-family:JetBrainsMono Nerd Font !important }
          '';
          userContent = 
          ''
            *{scrollbar-width:none !important}
          '';
        };
      };
    };

    foot = {
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

    git = {
      enable = true;
      userName = "DeviousCilantro";
      userEmail = "archisman@mailbox.org";
    };

    neovim = {
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

    zsh = {
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
          update = "doas nixos-rebuild switch --impure";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
        theme = "lambda";
      };
      profileExtra = ''
        if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
          exec sway &>/dev/null
        fi
      '';
    };

  };
    
  services = {
    dunst = {
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
          "F1" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && dunstify -r 991050 \"vol:$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -d':' -f2)\"";
          "XF86AudioLowerVolume" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 && wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.01- && dunstify -r 991050 \"vol:$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -d':' -f2)\"";
          "XF86AudioRaiseVolume" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 && wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.01+ && dunstify -r 991050 \"vol:$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -d':' -f2)\"";
          "XF86AudioMicMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle && wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 30% && dunstify -r 991050 \"mic:$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | cut -d':' -f2)\"";
          "F2" = "exec brightnessctl --device=\"asus::kbd_backlight\" s 1-";
          "F3" = "exec brightnessctl --device=\"asus::kbd_backlight\" s 1+";
          "Mod1+F2" = "exec asusctl led-mode -p";
          "Mod1+F3" = "exec asusctl led-mode -n";
          "F7" = "exec brightnessctl s 1%- && dunstify -r 991051 \"bri: $(brightnessctl | grep % | cut -d'(' -f2 | cut -d')' -f1)\"";
          "F8" = "exec brightnessctl s 1%+ && dunstify -r 991051 \"bri: $(brightnessctl | grep % | cut -d'(' -f2 | cut -d')' -f1)\"";
          "F5" = "exec playerctl play-pause && dunstify -r 991052 \"$(playerctl metadata xesam:artist) - $(playerctl metadata xesam:title)\"";
          "F4" = "exec playerctl previous && dunstify -r 991052 \"$(playerctl metadata xesam:artist) - $(playerctl metadata xesam:title)\"";
          "F6" = "exec playerctl next && dunstify -r 991052 \"$(playerctl metadata xesam:artist) - $(playerctl metadata xesam:title)\"";
          "Mod1+Shift+f" = "exec firefox";
          "Mod1+t" = "exec thunderbird";
          "Mod1+z" = "exec zathura";
          "Mod1+Shift+p" = "exec plexmediaplayer";
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
}
