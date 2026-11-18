{ pkgs, ... }:
let
  kavd-watchdog = pkgs.callPackage ../pkgs/kavd-watchdog.nix { };
in
{
  # command wraps the binary in wait4path, ProgramArguments spawns before /nix mounts at boot
  launchd.daemons.kavd-watchdog.command = "${kavd-watchdog}/bin/kavd-watchdog --service system/com.kaspersky.kav.kavd";
  launchd.daemons.kavd-watchdog.serviceConfig = {
    Label = "local.kavd-watchdog";
    RunAtLoad = true;
    KeepAlive = true;
    StandardOutPath = "/var/log/kavd-watchdog.log";
    StandardErrorPath = "/var/log/kavd-watchdog.log";
  };
}
