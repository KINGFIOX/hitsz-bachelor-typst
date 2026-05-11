{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    win10-fonts.url = "github:KINGFIOX/win10-fonts";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      win10-fonts,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
        win10Fonts = win10-fonts.packages.${system}.win10-fonts;
      in
      {
        packages.default = pkgs.stdenvNoCC.mkDerivation {
          pname = "bachelor-thesis";
          version = "0.1.0";
          src = ./.;

          nativeBuildInputs = [
            pkgs.typst
            win10Fonts
          ];

          dontConfigure = true;
          dontFixup = true;

          buildPhase = ''
            runHook preBuild
            export HOME="$TMPDIR"
            typst compile \
              --root . \
              --ignore-system-fonts --font-path ${win10Fonts}/share/fonts/truetype \
              main/bachelor.typ bachelor.pdf
            runHook postBuild
          '';

          installPhase = ''
            runHook preInstall
            mkdir -p "$out"
            cp bachelor.pdf "$out/"
            runHook postInstall
          '';
        };

        devShells.default = pkgs.mkShell {
          buildInputs =
            with pkgs;
            [
              typst
              win10Fonts
              nodejs_22 # used for mcp
            ]
            ;

          shellHook = ''
            export TYPST_FONT_PATHS="${win10Fonts}/share/fonts/truetype"
          '';
        };
      }
    );
}
