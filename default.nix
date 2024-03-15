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

            # Debuggung
            binwalk
            dtc
            hexedit
            (ubootTools.overrideAttrs (old: rec {
              defaultVersion = "2016.09";
              defaultSrc = pkgs.fetchurl {
                url = "https://ftp.denx.de/pub/u-boot/u-boot-${defaultVersion}.tar.bz2";
                hash = "sha256-mU57ng41DZ+R9YktXlv/ANNxSkli9SD3imSkYe+VC6k=";
              };
            }))
        ];
    }
