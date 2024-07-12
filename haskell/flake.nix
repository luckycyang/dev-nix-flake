{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    devenv.url = "github:cachix/devenv";
  };

  outputs = {
    self,
    nixpkgs,
    devenv,
    ...
  } @ inputs: let
    system = "x86_64-linux";

    pkgs = import nixpkgs {inherit system;};
  in {
    packages.${system}.devenv-up = self.devShells.${system}.default.config.procfileScript;

    devShells.${system}.default = devenv.lib.mkShell {
      inherit inputs pkgs;
      modules = [
        ({
          pkgs,
          config,
          ...
        }: {
          # This is your devenv configuration
          enterShell = ''
            echo Welcome developing haskell
          '';
          languages.haskell.enable = true;
        })
      ];
    };
  };
}
