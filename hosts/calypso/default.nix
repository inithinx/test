{
  pkgs,
  config,
  lib,
  ...
}: let
  MHz = x: x * 1000;
  inherit (lib) mkDefault;
in {
  imports = [./hardware-configuration.nix];
  environment.systemPackages = with pkgs; [
    acpi
    powertop
  ];

  services = {
    fprintd.enable = true;
    thermald.enable = true;
    power-profiles-daemon.enable = true;
    undervolt = {
      enable = true;
      coreOffset = -100;
      gpuOffset = -80;
      tempBat = 65;
    };
    # DBus service that provides power management support to applications.
    upower = {
      enable = true;
      percentageLow = 15;
      percentageCritical = 5;
      percentageAction = 3;
      criticalPowerAction = "Hibernate";
    };
    # superior power management (brought to you by raf :3)
    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governor = "powersave";
          scaling_min_freq = mkDefault (MHz 1800);
          scaling_max_freq = mkDefault (MHz 3600);
          turbo = "never";
        };
        charger = {
          governor = "performance";
          scaling_min_freq = mkDefault (MHz 2000);
          scaling_max_freq = mkDefault (MHz 4800);
          turbo = "auto";
        };
      };
    };
  };

  # https://github.com/NixOS/nixpkgs/issues/211345#issuecomment-1397825573
  systemd.tmpfiles.rules =
    map
    (
      e: "w /sys/bus/${e}/power/control - - - - auto"
    ) [
      "pci/devices/0000:00:01.0" # Renoir PCIe Dummy Host Bridge
      "pci/devices/0000:00:02.0" # Renoir PCIe Dummy Host Bridge
      "pci/devices/0000:00:14.0" # FCH SMBus Controller
      "pci/devices/0000:00:14.3" # FCH LPC bridge
      "pci/devices/0000:04:00.0" # FCH SATA Controller [AHCI mode]
      "pci/devices/0000:04:00.1/ata1" # FCH SATA Controller, port 1
      "pci/devices/0000:04:00.1/ata2" # FCH SATA Controller, port 2
      "usb/devices/1-3" # USB camera
    ];

  boot = {
    kernelModules = ["acpi_call"];
    extraModulePackages = with config.boot.kernelPackages;
      [
        acpi_call
        cpupower
      ]
      ++ [pkgs.cpupower-gui];
  };
  security.pam.services.login.fprintAuth = true;
  hardware.trackpoint = {
    enable = true;
    emulateWheel = true;
    speed = 30;
    sensitivity = 60;
  };
  hardware.opengl.extraPackages = with pkgs; [vaapiIntel libvdpau-va-gl vaapiVdpau];
}
