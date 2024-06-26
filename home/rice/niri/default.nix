{
  pkgs,
  lib,
  theme,
  ...
}: let
  mkService = lib.recursiveUpdate {
    Unit.PartOf = ["graphical-session.target"];
    Unit.After = ["graphical-session.target"];
    Install.WantedBy = ["graphical-session.target"];
  };
in {
  imports = [./config.nix];
  home.packages = with pkgs; [pamixer];
  services = {
    wlsunset = {
      # TODO: fix opaque red screen issue
      enable = true;
      latitude = "52.0";
      longitude = "21.0";
      temperature = {
        day = 6200;
        night = 3750;
      };
      systemdTarget = "niri.service";
    };
    cliphist.enable = true;
  };
  systemd.user.targets = {
    # fake a tray to let apps start
    # https://github.com/nix-community/home-manager/issues/2064
    tray = {
      Unit = {
        Description = "Home Manager System Tray";
        Requires = ["graphical-session-pre.target"];
      };
    };
  };

  systemd.user.services = {
    swaybg = mkService {
      Unit = {
        Description = "Wallpaper chooser";
        After = "niri.service";
      };
      Service = {
        ExecStart = "${lib.getExe pkgs.swaybg} -i ${theme.wallpaper}";
        Restart = "always";
      };
    };
  };
}
