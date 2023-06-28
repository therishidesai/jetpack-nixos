{ config, lib, pkgs, ... }:

let
  inherit (lib)
    mkEnableOption
    mkIf;
  cfg = config.services.jtop;
in
{

  options = {
    services.jtop = {
      enable = mkEnableOption "jtop";
    };
  };


  config = mkIf cfg.enable {
    systemd.services.jtop = mkIf cfg.enable {
      enable = true;
      description = "jtop service for jetson_stats";
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.nvidia-jetpack.jtop}/bin/jtop --force";
        Restart = "on-failure";
      };

      wantedBy = [ "multi-user.target" ];
    };

    environment.systemPackages = with pkgs.nvidia-jetpack; [ jtop ];
  };
}
