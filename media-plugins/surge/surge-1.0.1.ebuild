# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

EGIT_REPO_URI="https://github.com/surge-synthesizer/surge.git"
EGIT_COMMIT="60228e84944cdba072be2d43bd4fe97b82c30a86"

DESCRIPTION="Open source synthesizer plug-in"
HOMEPAGE="https://surge-synthesizer.github.io/"
LICENSE="GPL-3"
SLOT="0"
IUSE="-standalone -resources"
KEYWORDS="amd64"

DEPEND="
	media-libs/alsa-lib
	media-libs/freetype
	x11-libs/libXcursor
	x11-libs/libXinerama
	x11-libs/libXrandr
	media-sound/jack2
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-util/cmake
"

src_prepare() {
	eapply_user
}

src_configure() {
	cd ${S}
	mkdir build
	cd build
	cmake ${S} -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${D}/usr
}

src_compile() {
	cd ${S}
	cd build
	make ${MAKEOPTS}
}

src_install() {
	cd ${S}
	cd build
	make install
	use resources || rm -rf ${D}/usr/share
	use standalone || rm -rf ${D}/usr/bin
}
