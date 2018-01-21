let
  # Use pinned packages
  _nixpkgs = import <nixpkgs> {};
  nixpkgs = _nixpkgs.fetchFromGitHub (_nixpkgs.lib.importJSON ./nix/src.json);
  pkgs = import nixpkgs {};

  # Package GPP
  gppSrc = pkgs.fetchFromGitHub
    {
      owner = "logological";
      repo = "gpp";
      rev = "96c5dd8905384ea188f380f51d24cbd7fd58f642";
      sha256 = "0bvhnx3yfhbfiqqhhz6k2a596ls5rval7ykbp3jl5b6062xj861b";
    };
  gpp = pkgs.stdenv.mkDerivation
    {
      name = "gpp";
      src = gppSrc;
      nativeBuildInputs =
        [ pkgs.autoreconfHook
        ];
    };

  # "pdflatex" is needed by pandoc to produce the PDF
  pdflatex = with pkgs; pkgs.texlive.combine
    { inherit (texlive) scheme-small;
    };
in
  pkgs.stdenv.mkDerivation
  {
    name = "contract.pdf";
    src = ./src;

    builder = pkgs.writeScript "build-contract"
      ''
        source $stdenv/setup
        mkdir -p $out
        gpp \
          --include $src/variables \
          -H $src/contract.md \
          | pandoc -o $out/contract.pdf
      '';

    buildInputs =
    [ gpp
      pdflatex
      pkgs.pandoc
    ];
  }
