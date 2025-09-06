{
  description = "Build uv package from unstable nixpkgs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = f: builtins.listToAttrs (map (system: {
        name = system;
        value = f system;
      }) systems);
    in {
      packages = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in {
          default = pkgs.uv;
          uv = pkgs.uv;
        }
      );

      # optional shortcut: expose uv also at the top level
      defaultPackage = forAllSystems (system: (import nixpkgs { inherit system; }).uv);
    };
}
