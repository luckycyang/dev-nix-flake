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
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    packages.${system} = {
      projectA-devenv-up = self.devShells.${system}.projectA.config.procfileScript;
      projectB-devenv-up = self.devShells.${system}.projectB.config.procfileScript;
    };

    devShells.${system} = {
      projectA = devenv.lib.mkShell {
        inherit inputs pkgs;
        modules = [
          {
            enterShell = ''
              echo this is project A
            '';
          }
        ];
      };

      projectB = devenv.lib.mkShell {
        inherit inputs pkgs;
        modules = [
          {
            enterShell = ''
              echo this is project B
            '';
          }
        ];
      };
    };
  };
}
