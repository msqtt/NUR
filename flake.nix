{
  description = "My personal NUR repository";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.jbl.url = "github:orzation/jbl";

  outputs = { self, nixpkgs, ... } @inputs:
    let
      systems = [
        "x86_64-linux"
        "i686-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "armv6l-linux"
        "armv7l-linux"
      ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);
    in
    {
      legacyPackages = forAllSystems (system:
        let
          defaultResult = import ./default.nix {
            pkgs = import nixpkgs { inherit system; };
          };
          jblPackage = { jbl = inputs.jbl.defaultPackage.${system}; };
        in
          defaultResult // jblPackage
      );
      packages = forAllSystems (system: nixpkgs.lib.filterAttrs (_: v: nixpkgs.lib.isDerivation v) self.legacyPackages.${system});
    };
}
