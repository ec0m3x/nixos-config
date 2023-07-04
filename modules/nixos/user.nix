{ pkgs
, inputs
, ...
}:
let
  name = "Sebastian";
  username = "ec0m3x";
  email = "skoch@sks-concept.de";
  initialPassword = "geheim";
  packages = with pkgs; [
    fish
  ];
in
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs; };
    users.${username} = {
      imports = [ (import ./../home-manager) ];
      home.username = username;
      home.homeDirectory = "/home/${username}";
      home.stateVersion = "23.05";
      programs.home-manager.enable = true;
    };
  };

  users.users.${username} = {
    isNormalUser = true;
    initialPassword = initialPassword;
    description = name;
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };
  users.users.root.initialPassword = initialPassword;
  # services.getty.autologinUser = "${username}";
  nix.settings.allowed-users = [ "${username}" ];

}
