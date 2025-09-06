{
  description = "Build uv package from unstable nixpkgs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
    let
      system = "aarch64-darwin";
      pkgs = import nixpkgs { inherit system; };
      uvPkg = pkgs.uv;  # or adjust for your Python version
    in
    {
      packages.${system}.default = uvPkg;
    };
}
