{ pkgs, unstable, ... }: {
  programs.thunderbird = {
    enable = true;
    package = unstable.thunderbird;
    profiles.ec0m3x.isDefault = true;
  };
}
