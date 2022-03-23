# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

EGIT_REPO_URI="https://github.com/taylordotfish/vital"
EGIT_COMMIT="3abc91e41eb639c77863e143209f0c3ff8aa2132"

DESCRIPTION="Vital Audio synthesizer"
HOMEPAGE="https://vital.audio"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="+lv2 +vst +vst3 -standalone"

DEPEND="
	media-libs/alsa-lib
	media-libs/freetype
	x11-libs/libX11
	x11-libs/libXrandr
	x11-libs/libXinerama
	x11-libs/libXcursor
	virtual/opengl
	dev-libs/glib
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-util/cmake
"
src_prepare() {
	default
	sed -i -e "s/Vital/Vial/g" Makefile
}
src_compile() {
	use lv2 && emake lv2
	use vst && emake vst
	use vst3 && emake vst3
	use standalone && emake standalone
}

src_install() {
	export PREFIX=${D}/usr
	export LIBDIR=${PREFIX}/lib64
	use lv2 && emake install_lv2
	use vst && emake install_vst
	use vst3 && emake install_vst3
	use standalone && emake install_standalone
}
