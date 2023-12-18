{ lib
, stdenv
, fetchurl
, librsvg
, libX11
, harfbuzz
, meson
, ninja
, pkg-config
, cmake
, ...
}:
stdenv.mkDerivation
rec {
  pname = "freetype";
  version = "2.13.0";

  src = fetchurl {
    url = "https://download-mirror.savannah.gnu.org/releases/freetype/freetype-${version}.tar.xz";
    sha256 = "sha256-XuI6vQR2NsJLLUPGYl3K/GZmHRrKZN7J4NBd8pWSYkw=";
  };

  nativeBuildInputs = [
    meson
    pkg-config
    cmake
    ninja
  ];

  buildInputs = [
    librsvg
    libX11
    harfbuzz
  ];

  patches = [
    ./patch/0001-Enable-table-validation-modules.patch
    ./patch/0002-Enable-subpixel-rendering.patch
    ./patch/0003-Enable-infinality-subpixel-hinting.patch
    ./patch/0004-Enable-long-PCF-family-names.patch
    ./patch/0005-builds-meson-parse_modules_cfg.py-Handle-gxvalid-and.patch
  ];

  mesonFlags = [ "-D" "freetype2:default_library=shared" ];
}
