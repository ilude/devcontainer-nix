{ pkgs ? import <nixpkgs> { } }:
with pkgs;
stdenv.mkDerivation rec {
  pname = "default";
  version = "1.0";
  src = ./.;
  propagatedBuildInputs = [
    makeWrapper
    zsh
    git
    sudo
    su
    which
    direnv 
    nix-direnv 
    findutils
    getent
  ];
  dontBuild = true;
  installPhase = ''
    mkdir -p $out/lib $out/bin
    ln -sf "${sudo}/bin/sudo" $out/bin/sudo
    ln -sf "${su}/bin/su" $out/bin/su
    ln -sf "${which}/bin/which" $out/bin/which
  '';
  meta = {
    priority = 7;
    description = "VS Code devcontainer with Nix";
    maintainers = [ "Rizky Maulana Nugraha <lana.pcfre@gmail.com>" ];
  };
}