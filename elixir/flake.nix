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
        # flake contents here
        devShells = {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [
              elixir_1_16
              nodejs
              postgresql_16
            ];
          };
        };
      }
    );
}
