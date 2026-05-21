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

        # texliveFull contains every CTAN package: ctex / xeCJK / fandol /
        # tikz / tikz-timing / pgfplots / listings / hyperref / biblatex /
        # splitindex / latexmk and so on. The hithesis class itself is not
        # installed by texlive; we ship a copy under
        # template/latex/examples/hitbook/chinese/ and add it to TEXINPUTS so
        # xelatex can pick up *.cls / *.cfg / *.sty / *.bst / *.ist / *.eps.
        texlive = pkgs.texliveFull;

        hithesisAssets = ./template/latex/examples/hitbook/chinese;

        # win10-fonts ships SimSun / SimHei / FangSong / KaiTi etc. into
        # share/fonts/truetype. Pointing OSFONTDIR at that directory makes
        # them visible to xelatex's font picker, which is what
        # `\documentclass[fontset=windows,...]{hithesisbook}` expects.
        latexFontPath = "${win10Fonts}/share/fonts/truetype";
      in
      {
        packages.default = pkgs.stdenvNoCC.mkDerivation {
          pname = "bachelor-thesis";
          version = "0.1.0";
          src = ./.;

          nativeBuildInputs = [
            texlive
            win10Fonts
            pkgs.coreutils
            pkgs.which
          ];

          dontConfigure = true;
          dontFixup = true;

          buildPhase = ''
            runHook preBuild
            export HOME="$TMPDIR"
            export OSFONTDIR="${latexFontPath}"
            # NOTE: do not use `//` recursive globs here. The hithesis chinese/
            # directory ships its own example `thesis.tex` and `front/cover.tex`
            # etc.; if we expose them recursively, kpsewhich shadows our local
            # `main/thesis.tex` and `main/front/cover.tex` with the template's
            # demo files. Adding only the top-level dir is enough because we
            # only need the *.cls / *.cfg / *.sty / *.bst / *.ist / *.eps that
            # all live at the root of chinese/.
            export TEXINPUTS=".:${hithesisAssets}:"
            export BIBINPUTS=".:"
            export BSTINPUTS=".:${hithesisAssets}:"
            cd main
            latexmk -xelatex -interaction=nonstopmode -file-line-error -halt-on-error ./thesis.tex
            runHook postBuild
          '';

          installPhase = ''
            runHook preInstall
            mkdir -p "$out"
            cp thesis.pdf "$out/bachelor.pdf"
            runHook postInstall
          '';
        };

        devShells.default = pkgs.mkShell {
          buildInputs = [
            texlive
            win10Fonts
            pkgs.nodejs_22 # used for mcp
          ];

          # Mirror the build environment so that running `cd main && latexmk`
          # inside `nix develop` reproduces what `nix build` does.
          shellHook = ''
            export OSFONTDIR="${latexFontPath}"
            export TEXINPUTS=".:${hithesisAssets}:"
            export BSTINPUTS=".:${hithesisAssets}:"
          '';
        };
      }
    );
}
