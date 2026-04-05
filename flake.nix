{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        fonts = with pkgs; [
          corefonts
          vista-fonts
          vista-fonts-chs
        ];

        fontPaths = builtins.concatStringsSep ":" (
          map (f: "${f}/share/fonts") fonts
        );
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            typst
          ] ++ fonts;

          shellHook = ''
            export TYPST_FONT_PATHS="${fontPaths}"
          '';
        };
      }
    );
}
