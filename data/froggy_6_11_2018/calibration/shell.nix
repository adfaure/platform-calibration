# Setup the analysis environment by typing:
let
  pkgs = import (builtins.fetchTarball {
    # Descriptive name to make the store path easier to identify
    name = "nixos-1803-2018-10-18";
    # Archive from commit hash
    url = "https://github.com/NixOS/nixpkgs/archive/18.03.tar.gz";
    # Hash obtained using `nix-prefetch-url --unpack <url>` on the URL above
    sha256 = "0hk4y2vkgm1qadpsm4b0q1vxq889jhxzjx3ragybrlwwg54mzp4f";
  }) {};
in
pkgs.mkShell {
  buildInputs = [
    (with pkgs.rPackages; [
      pkgs.R
      webshot
      XML
      pkgs.pandoc
      tidyverse
      knitr
      rmarkdown
      lubridate
      xts
      dygraphs
      viridis
      plotly
      pkgs.hdf5
      (rhdf5.overrideDerivation (attrs: {
        nativeBuildInputs = attrs.nativeBuildInputs ++ [ pkgs.zlib pkgs.hdf5 ];
        patches = [
          (pkgs.writeText "konfig.patch" ''
      diff --git a/configure b/configure
      index e3e21e8..3d947b6 100755
      --- a/configure
      +++ b/configure
      @@ -2859,6 +2859,7 @@ fi;

       echo "building the bundled hdf5 library...";
       cd ''${BASEPBNAME};
      +sed -i 's#/bin/mv#mv#' configure
       ./configure  --with-pic --enable-shared=no CXX="''${CXX}" CXXFLAGS="''${CXXFLAGS}" CC="''${CC}" CFLAGS="''${CFLAGS}" F77="''${F77}"
       $MAKE lib
       cd ../../
       ''
         )];
      }))
    ])
  ];
}
