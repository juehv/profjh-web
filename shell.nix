{ pkgs ? import <nixpkgs> {} }:

let
  libs = [
    pkgs.stdenv.cc.cc.lib        # libstdc++.so.6

    # X11 / XCB
    pkgs.xorg.libX11
    pkgs.xorg.libXext
    pkgs.xorg.libXrandr
    pkgs.xorg.libXcomposite
    pkgs.xorg.libXcursor
    pkgs.xorg.libXdamage
    pkgs.xorg.libXfixes
    pkgs.xorg.libXi
    pkgs.xorg.libXrender
    pkgs.xorg.libxcb

    # GTK / Cairo / GDK
    pkgs.gtk3
    pkgs.pango
    pkgs.atk
    pkgs.cairo
    pkgs.gdk-pixbuf
    pkgs.glib

    # Fonts
    pkgs.freetype
    pkgs.fontconfig

    # Audio + DBus
    pkgs.alsa-lib
    pkgs.dbus
  ];
in
pkgs.mkShell {
  buildInputs = libs ++ [
    pkgs.nodejs_20                # add Node.js here
    pkgs.sshpass                  # SFTP deployment
  ];

  shellHook = ''
    export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath libs}:$LD_LIBRARY_PATH"
    echo "LD_LIBRARY_PATH set."
    export PORT=8081
    echo "Set PORT to 8081"
  '';
}
