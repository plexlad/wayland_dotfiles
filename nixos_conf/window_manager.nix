{ pkgs, ... }:
{
  ## Hyprland Configuration ##
  programs.hyprland = {
    enable = true;
    #nvidiaPatches = true # If using nvidia based GPU
    xwayland.enable = true;
  };
}
