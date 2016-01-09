{ pkgs ? import <nixpkgs> {} }:
with pkgs; stdenv.mkDerivation {
  name = "xkcd-random";
  version = "0.1.0";
  src = ./.;
  buildInputs = [ makeWrapper ];
  installPhase = ''
    mkdir -p $out/bin
    cp xkcd-random xkcd-random-cgi $out/bin
    wrapProgram $out/bin/xkcd-random --prefix PATH : ${curl}/bin
    wrapProgram $out/bin/xkcd-random-cgi --prefix PATH : $out/bin
  '';
}
