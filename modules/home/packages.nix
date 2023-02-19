{
  inputs,
  pkgs,
  config,
  ...
}: {
  nixpkgs.config.allowUnfree = false;
  home.packages = with pkgs; [
    cached-nix-shell
    todo
    qalculate-gtk
    nheko
    yt-dlp
    tdesktop
    tracy
    hyperfine
    fzf
    glow
    nmap
    unzip
    ripgrep
    rsync
    ttyper
    wine
    session-desktop
    fractal
    tor-browser-bundle-bin
    tessen
    gopass
    ffmpeg
    gimp
    imagemagick
    aseprite
    transmission-gtk
    bandwhich
    grex
    fd
    xfce.thunar
    xh
    jq
    figlet
    lm_sensors
    keepassxc
    dconf
    gcc
  ];
}
