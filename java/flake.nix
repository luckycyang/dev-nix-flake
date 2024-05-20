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
        javaVersion = 8;
        overlays = [
          (final: prev: rec {
            jdk = prev."jdk${toString javaVersion}"; # openjdk
            # jdk = prev."oraclejdk${toString javaVersion}";
            # jre = prev."oraclejre${toString javaVersion}";
            jre = prev."jre${toString javaVersion}";
            gradle = prev.gradle.override {java = jdk;};
            maven = prev.maven.override {inherit jdk;};
            mill = prev.mill.override {inherit jre;};
          })
        ];
      in {
        # flake contents here
        devShells = {
          default = pkgs.mkShell {
            packages = with pkgs; [
              mill
              jdk
              jre
            ];
          };
        };
      }
    );
}
