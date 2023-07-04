{ pkgs, ... }:
{
    services = {
      printing = {
        enable = true;
        drivers = [ pkgs.hplipWithPlugin ];
      };
      avahi = {
        enable = true;
        nssmdns = true;
        publish = {
          enable = true;
          addresses = true;
          userServices = true;
        };
      };
    };
}