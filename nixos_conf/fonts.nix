{ pkgs, ... }:
{
  # Font configuration
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "CodeNewRoman" "JetBrainsMono" "FiraCode" ]; }) # Set dev fonts
    jetbrains-mono
    fira-code
    fira-code-symbols
    fira-code-nerdfont
  ];
}
