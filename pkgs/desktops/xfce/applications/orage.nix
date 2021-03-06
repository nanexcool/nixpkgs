{ stdenv, fetchurl, fetchpatch, pkgconfig, bison, flex, intltool, gtk, libical, dbus-glib
, libnotify, popt, xfce
}:

stdenv.mkDerivation rec {
  name = "${p_name}-${ver_maj}.${ver_min}";
  p_name  = "orage";
  ver_maj = "4.12";
  ver_min = "1";

  src = fetchurl {
    url = "mirror://xfce/src/apps/${p_name}/${ver_maj}/${name}.tar.bz2";
    sha256 = "0qlhvnl2m33vfxqlbkic2nmfpwyd4mq230jzhs48cg78392amy9w";
  };

  patches = [
    # Fix build with libical 3.0
    (fetchpatch {
      name = "fix-libical3.patch";
      url = https://git.archlinux.org/svntogit/packages.git/plain/trunk/libical3.patch?h=packages/orage&id=7b1b06c42dda034d538977b9f3550b28e370057f;
      sha256 = "1l8s106mcidmbx2p8c2pi8v9ngbv2x3fsgv36j8qk8wyd4qd1jbf";
    })
  ];

  nativeBuildInputs = [ pkgconfig intltool bison flex ];

  buildInputs = [ gtk libical dbus-glib libnotify popt xfce.libxfce4util
    xfce.xfce4-panel ];

  preFixup = "rm $out/share/icons/hicolor/icon-theme.cache ";

  meta = {
    homepage = http://www.xfce.org/projects/;
    description = "A simple calendar application with reminders";
    license = stdenv.lib.licenses.gpl2;
    platforms = stdenv.lib.platforms.linux;
    maintainers = [ stdenv.lib.maintainers.romildo ];
  };
}
