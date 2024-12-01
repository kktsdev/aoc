{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05-small";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = {flake-utils, ...} @ inputs:
    flake-utils.lib.eachDefaultSystem (system: let
      nixpkgs = inputs.nixpkgs.legacyPackages.${system};
    in {
      devShells.default = nixpkgs.mkShell {
        nativeBuildInputs = [nixpkgs.ghc];
      };
    });
}
