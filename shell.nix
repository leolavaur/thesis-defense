let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/36bae45077667aff5720e5b3f1a5458f51cf0776";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in pkgs.mkShellNoCC {
  buildInputs = with pkgs; [
    texliveFull
  ];
}