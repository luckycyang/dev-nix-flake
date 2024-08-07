{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }: {
    templates = rec {
      simple = {
        path = ./simple;
        description = "simple flake template with nixpkgs-unstable and flake utils";
      };
      python = {
        path = ./python;
        description = "Python311 with requests and pandas";
      };
      rust = {
        path = ./rust;
        description = "simple rust with toolchain";
      };
      cpp = {
        path = ./cpp;
        description = "蓝桥";
      };
      elixir = {
        path = ./elixir;
        description = "elixir";
      };
      java = {
        path = ./java;
        description = "java";
      };
      scala = {
        path = ./scala;
        description = "scala env with devenv";
      };
      openfpga = {
        path = ./fpga;
        description = "open fpga toolchain with yosys and nextptr";
      };
      haskell = {
        path = ./haskell;
        description = "haskell env in devenv";
      };
      devenv = {
        path = ./devenv;
        description = "devenv template for devenv doc";
      };
    };
  };
}
