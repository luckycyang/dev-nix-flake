{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem
    (
      system: let
        pkgs = import nixpkgs {inherit system;};
      in {
        devShells = {
          default = pkgs.mkShell.override {stdenv = pkgs.clangStdenv;} {
            name = "simple";
            buildInputs = with pkgs;
              [
                fd
                eza
              ];
            shellHook = ''
              alias find=fd
              alias ls=eza
            '';
          };
        };
      }
    );
}
