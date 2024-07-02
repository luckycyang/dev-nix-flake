{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    devshell.url = "github:numtide/devshell";
    flake-utils.url = "github:numtide/flake-utils";
    android.url = "github:tadfisher/android-nixpkgs";
  };
  outputs = {
    self,
    nixpkgs,
    devshell,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem
    (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [
            devshell.overlay
          ];
        };
      in {
        # flake contents here
        devShells = {
          default = pkgs.mkShell {
            # env
            ANDROID_HOME = "${pkgs.android-sdk}/share/android-sdk";
            ANDROID_SDK_ROOT = "${pkgs.android-sdk}/share/android-sdk";
            PATH = "${pkgs.android-sdk}/share/android-sdk/emulator:${pkgs.android-sdk}/share/android-sdk/platform-tools";
            buildInputs = with pkgs; [
              android-sdk
              gradle
              jdk17
              pkg-config
              nodejs
            ];
          };
        };
      }
    );
}
