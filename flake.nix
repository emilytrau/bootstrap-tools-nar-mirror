{
  description = "NAR archive mirror for bootstrap source packages";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.flake-utils.inputs.nixpkgs.follows = "nixpkgs";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        version = builtins.toString (import ./release-version.nix);
        sources = flake-utils.lib.flattenTree (pkgs.callPackage ./sources.nix { });
        mirror = pkgs.symlinkJoin {
          name = "bootstrap-tools-nar-mirror-${version}";
          paths = builtins.attrValues sources;
        };
      in
      {
        packages = sources // {
          inherit mirror;
          default = mirror;
        };
      }
    );
}
