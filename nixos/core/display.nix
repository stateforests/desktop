{ pkgs, ... }:

{
  # display manager
  services.greetd = {
    enable = true;

    settings.default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd '${pkgs.jay}/bin/jay run'";
      user = "atlas";
    };
  };
}