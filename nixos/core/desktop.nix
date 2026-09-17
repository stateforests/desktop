{ inputs, pkgs, ... }:

let
  jay = inputs.jay.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  services.greetd = {
    enable = true;

    settings.default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd '${jay}/bin/jay run'";
      user = "atlas";
    };
  };

  programs.xwayland.enable = true;

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
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
      config.common.default = [ "wlr" "gtk" ];
    };
  };
}