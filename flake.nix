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

          packages =
            with pkgs;
            [
              typst
              win10Fonts
            ]
            ;

          dontConfigure = true;
          dontFixup = true;

          buildPhase = ''
            runHook preBuild
            export HOME="$TMPDIR"
            export TYPST_FONT_PATHS="${win10Fonts}/share/fonts/truetype"
            unset SOURCE_DATE_EPOCH # Let Typst use real system time instead of reproducible-build epoch.
            typst compile --root . main/bachelor.typ bachelor.pdf
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
            ]
            ;

          shellHook = ''
            unset SOURCE_DATE_EPOCH
            export TYPST_FONT_PATHS="${win10Fonts}/share/fonts/truetype"
          '';
        };
      }
    );
}
