# This module defines a small NixOS configuration.  It does not
# contain any graphical stuff.

{ config, lib, ... }:

with lib;

{
  environment.noXlibs = mkDefault true;

  documentation.enable = mkDefault false;

  documentation.doc.enable = mkDefault false;

  documentation.info.enable = mkDefault false;

  documentation.man.enable = mkDefault false;

  documentation.nixos.enable = mkDefault false;

  # Perl is a default package.
  environment.defaultPackages = mkDefault [ ];

  environment.stub-ld.enable = false;

  # The lessopen package pulls in Perl.
  programs.less.lessopen = mkDefault null;

  # This pulls in nixos-containers which depends on Perl.
  boot.enableContainers = mkDefault false;

  programs.command-not-found.enable = mkDefault false;

  services.logrotate.enable = mkDefault false;

  services.udisks2.enable = mkDefault false;

  xdg.autostart.enable = mkDefault false;
  xdg.icons.enable = mkDefault false;
  xdg.mime.enable = mkDefault false;
  xdg.sounds.enable = mkDefault false;

  systemd.services."serial-getty@".environment.TERM = "xterm-256color";

  systemd.services."serial-getty@ttyUSB0" = {
    enable = true;
    wantedBy = [ "getty.target" ]; # to start at boot
    serviceConfig.Restart = "always"; # restart when session is closed
  };

  users.users.root.extraGroups = [ "dialout" ];

}
