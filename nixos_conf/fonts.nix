{ pkgs, ... }:
let
  times-new-roman = pkgs.stdenv.mkDerivation {
    pname = "times-new-roman";
    version = "1";

    src = ./times-new-roman.zip;

    unpackPhase = ''
      runHook preUnpack
      ${pkgs.unzip}/bin/unzip $src

      runHook postUnpack
    '';

    installPhase = ''
      runHook preInstall

      install -Dm644 times.ttf -t $out/share/fonts/truetype

      runHook postInstall
    '';
  };
in {
  # Font configuration
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "CodeNewRoman" "JetBrainsMono" "FiraCode" ]; }) # Set dev fonts
    jetbrains-mono
    fira-code
    fira-code-symbols
    fira-code-nerdfont
    times-new-roman
  ];
}
