{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nixvim.url = "github:luckycyang/nixvim";
  };
  outputs = {
    self,
    nixpkgs,
    nixvim,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem
    (
      system: let
        pkgs = import nixpkgs {inherit system;};
      in {
        devShells = rec {
          cshabi = pkgs.mkShell.override {stdenv = pkgs.clangStdenv;} {
            name = "clangenv";
            buildInputs = with pkgs;
              [
                cmake
                gdb
                gnumake
                fd
                eza
              ]
              ++ [nixvim.packages.${pkgs.system}.default];
            shellHook = ''
              alias clang="clang++ -std=c++11"
              alias ++="clang++ -std=c++11"
              alias find=fd
              alias ls=eza
            '';
          };
          gshabi = pkgs.mkShell {
            name = "gccenv";
            buildInputs = with pkgs;
              [
                cmake
                gdb
                gnumake
                fd
                eza
              ]
              ++ [nixvim.packages.${pkgs.system}.default];
            shellHook = ''
              alias clang="g++ -std=c++11"
              alias ++="g++ -std=c++11"
              alias find=fd
              alias ls=eza
            '';
          };
          default = cshabi;
        };
        # flake contents here
      }
    );
}
