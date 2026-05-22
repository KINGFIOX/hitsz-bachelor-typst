{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      {
        packages.default = pkgs.stdenvNoCC.mkDerivation {
          pname = "bachelor-thesis";
          version = self.shortRev or "dirty";
          src = ./.;

          nativeBuildInputs = [
            pkgs.typst
          ];

          dontConfigure = true;
          dontFixup = true;

          # Fonts are bundled in ./fonts (Times New Roman, SimSun, SimHei,
          # KaiTi, Consolas, Courier New, Segoe UI Symbol) so that the build
          # is fully self-contained and reproducible without an external
          # win10-fonts flake. SimSun-ExtB (simsunb.ttf) is intentionally
          # NOT included; including it would require backporting typst PR
          # #8042 to keep macOS picking the right SimSun.
          buildPhase = ''
            runHook preBuild
            export HOME="$TMPDIR"
            export TYPST_FONT_PATHS="$PWD/fonts"
            export TYPST_IGNORE_SYSTEM_FONTS=true
            export TYPST_PACKAGE_PATH="$PWD/vendor/typst-packages"
            typst compile \
              --root . \
              --package-path "$TYPST_PACKAGE_PATH" \
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
          buildInputs = [
            pkgs.typst
            pkgs.nodejs_22 # used for mcp
          ];

          # `TYPST_FONT_PATHS` is consumed by:
          #   - `typst` CLI invocations from the terminal
          #   - tinymist preview: the mkhl.direnv extension auto-loads
          #     `.envrc` (`use flake`) on workspace open and injects this
          #     variable into the tinymist LSP process. So preview,
          #     terminal `typst`, and `nix build` all resolve fonts from
          #     the project-local `./fonts` directory.
          shellHook = ''
            export TYPST_IGNORE_SYSTEM_FONTS=true
            export TYPST_FONT_PATHS="$PWD/fonts"
            export TYPST_PACKAGE_PATH="$PWD/vendor/typst-packages"
          '';
        };
      }
    );
}
