{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
        name = "frc_simulate";
        buildInputs = with pkgs; [
            ninja
            gcc
            python3
            python311Packages.sphinx
            pkg-config
            sparse
            glib
        ];
    }
