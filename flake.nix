{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = {flake-utils, ...} @ inputs:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = inputs.nixpkgs.legacyPackages.${system};
    in {
      devShells.default = pkgs.mkShell {
        nativeBuildInputs = [
          (pkgs.haskellPackages.ghcWithPackages (pkgs: [pkgs.regex-tdfa pkgs.split]))
        ];
      };
    });
}