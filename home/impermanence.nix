_: {
  home.persistence."/persist/home/sioodmy" = {
    allowOther = true;
    files = [
      ".database.kdbx"
      ".cache/anyrun-ha-assist.sqlite3"
    ];
    directories = [
      "download"
      "music"
      "dev"
      "docs"
      ".keepass"
      "vids"
      "other"
      {
        directory = ".local/share/zoxide";
        method = "symlink";
      }
      {
        directory = ".steam";
        method = "symlink";
      }
      ".local/share/Steam"
      ".ssh"
      ".local/share/direnv"
      ".cache/tealdeer"
      ".local/share/distrobox"
      ".cache/containers"
      ".config/syncthing"
      ".cache/flutter"
      ".local/share/PrismLauncher"
      ".local/share/TelegramDesktop"
      ".local/share/keyrings"
      ".config/Caprine"
      ".cache/keepassxc"
      ".config/WebCord"
      ".config/easyeffects"
      ".config/BraveSoftware/"
      ".config/spotify-tui"
      ".cache/BraveSoftware/"
      ".cache/nix"
      ".cache/thunderbird/"
      ".thunderbird"
      ".cache/spotifyd"
      ".config/spotify"
      ".cache/starship"
      ".local/share/nheko"
      ".cache/nheko"
      ".config/nheko"
      ".cache/nix-index"
      ".config/obs-studio"
      ".mozilla"
      ".cache/mozilla"
    ];
  };
}
