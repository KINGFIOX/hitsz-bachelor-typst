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

        # Backport https://github.com/typst/typst/pull/8042 (merged 2026-03-30)
        # onto typst 0.14.2 (released 2025-12-12). Without it,
        # `typographic_family()` strips the "ExtB" suffix from "SimSun-ExtB" as
        # if it were an "ExtraBold" variant, merging SimSun-ExtB into the
        # SimSun family. Both then register as Normal/400 and `book.select()`
        # picks one non-deterministically; on macOS the build picks
        # SimSun-ExtB (no basic CJK glyphs) and silently falls back to
        # KaiTi/NSimSun, while CI on Linux happens to pick the right SimSun.
        #
        # The patch is contained to crates/typst-library/src/text/font/exceptions.rs
        # and does not touch Cargo.lock, so the upstream cargoHash stays valid.
        # Drop this override once nixpkgs ships a typst release containing #8042.
        typst = pkgs.typst.overrideAttrs (old: {
          patches = (old.patches or [ ]) ++ [
            (pkgs.fetchpatch {
              name = "typst-pr-8042-fix-simsun-extb.patch";
              url = "https://github.com/typst/typst/commit/7652884e3b26fd3161ce7768c90e2b5892a2111d.patch";
              hash = "sha256-XvQzIcU1kui2+2a/QSkhSDbNY5RIi8m9VZODgJwihdM=";
            })
          ];
        });

        typstFontPath = "${win10Fonts}/share/fonts/truetype";
      in
      {
        packages.default = pkgs.stdenvNoCC.mkDerivation {
          pname = "bachelor-thesis";
          version = self.shortRev or "dirty";
          src = ./.;

          nativeBuildInputs = [
            typst
            win10Fonts
          ];

          dontConfigure = true;
          dontFixup = true;

          buildPhase = ''
            runHook preBuild
            export HOME="$TMPDIR"
            export TYPST_FONT_PATHS="${typstFontPath}"
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
            typst
            win10Fonts
            pkgs.nodejs_22 # used for mcp
          ];

          # `TYPST_FONT_PATHS` is consumed by:
          #   - `typst` CLI invocations from the terminal
          #   - tinymist preview, via `.vscode/settings.json`'s
          #     `tinymist.fontPaths: ["${"$"}{env:TYPST_FONT_PATHS}"]`.
          #     This works because the mkhl.direnv extension auto-loads
          #     `.envrc` (`use flake`) on workspace open and injects this
          #     variable into the tinymist LSP process; tinymist then
          #     substitutes `${"$"}{env:...}` before passing paths to the
          #     compiler. So preview, terminal `typst`, and `nix build` all
          #     resolve fonts from the same nix-store directory.
          shellHook = ''
            export TYPST_IGNORE_SYSTEM_FONTS=true
            export TYPST_FONT_PATHS="${typstFontPath}"
            export TYPST_PACKAGE_PATH="$PWD/vendor/typst-packages"
          '';
        };
      }
    );
}
