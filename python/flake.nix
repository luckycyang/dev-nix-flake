{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # keras 识别不到
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.11"; #
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem
    (
      system: let
        pkgs = import nixpkgs-stable {
          inherit system;
          config.allowUnfree = true;
        };
      in
        with pkgs; {
          devShells = {
            default = mkShell.override {stdenv = clangStdenv;} {
              packages = [
                (python3.withPackages (ps: with ps; [requests pandas]))
              ];
            };
            tensorflow = pkgs.mkShellNoCC {
              packages = with pkgs; [
                (python3.withPackages (ps:
                  with ps; [
                    pandas
                    numpy
                    matplotlib
                    tensorflow
                    scikit-learn
                    keras
                  ]))
                libz
                cudaPackages.cudatoolkit
              ];
            };
            venv = pkgs.mkShell {
              name = "python-venv";
              buildInputs = with pkgs; [
                python311
                python311Packages.virtualenv
                python311Packages.pip
              ];
            };
          };
        }
    );
}
