#
# Git
#
{pkgs
, ...
}:{
  programs.git.enable = true;
  programs.git.userName = "3c0m3x";
  programs.git.userEmail = "skoch@sks-concept.de";
  home.packages = [ pkgs.gh ];
}
