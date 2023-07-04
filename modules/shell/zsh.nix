#
# Shell
#

{ pkgs, ... }:

{
  programs = {
    zsh = {
      enable = true;
      autosuggestions.enable = true;            # Auto suggest options and highlights syntax, searches in history for options
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      histSize = 100000;

      ohMyZsh = {                               # Extra plugins for zsh
        enable = true;
        plugins = [ "extract" "git" ];
        theme = "dst";
      };
    };
  };
}