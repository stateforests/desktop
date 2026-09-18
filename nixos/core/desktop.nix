{ pkgs, ... }:

{
  services.greetd = {
    enable = true;

    settings.default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd '${pkgs.jay}/bin/jay run'";
      user = "atlas";
    };
  };

  programs.xwayland.enable = true;

  programs.dconf = {
    enable = true;
    profiles.user.databases = [{
      settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
        };
      };
    }];
  };

  services.flatpak.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    XCURSOR_THEME = "Adwaita";
    XCURSOR_SIZE = "24";
  };

  xdg = {
    mime = {
      enable = true;

      defaultApplications = {
        "text/html" = "helium.desktop";
        "application/xhtml+xml" = "helium.desktop";
        "x-scheme-handler/http" = "helium.desktop";
        "x-scheme-handler/https" = "helium.desktop";
        "x-scheme-handler/chrome" = "helium.desktop";

        "image/jpeg" = "swayimg.desktop";
        "image/png" = "swayimg.desktop";
        "image/gif" = "swayimg.desktop";
        "image/webp" = "swayimg.desktop";
        "image/svg+xml" = "swayimg.desktop";

        "video/mp4" = "mpv.desktop";
        "video/x-matroska" = "mpv.desktop";
        "video/webm" = "mpv.desktop";
        "video/quicktime" = "mpv.desktop";
      };
    };

    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
      config.common.default = [ "gtk" ];
    };
  };
}