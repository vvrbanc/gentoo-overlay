# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#CMAKE_MAKEFILE_GENERATOR="emake"
inherit git-r3 #cmake

EGIT_REPO_URI="https://github.com/surge-synthesizer/surge.git"
EGIT_COMMIT="60228e84944cdba072be2d43bd4fe97b82c30a86"

DESCRIPTION="Open source synthesizer plug-in"
HOMEPAGE="https://surge-synthesizer.github.io/"
LICENSE="GPL-3"
SLOT="0"
IUSE="-standalone -resources" # The VST2 SDK is only available to licensed developers
KEYWORDS="amd64"

#	x11-libs/cairo
#	x11-libs/libxcb
#	x11-libs/libxkbcommon[X]
#	x11-libs/xcb-util-cursor
#	x11-libs/xcb-util-keysyms
DEPEND="
	x11-libs/libX11
	x11-libs/libXrandr
	x11-libs/libXinerama
	x11-libs/libXcursor
	media-libs/freetype
	media-libs/alsa-lib
	media-sound/jack2
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-util/cmake
"

#PATCHES=(
#	"${FILESDIR}/fix_stack.patch"
#	"${FILESDIR}/prevent_stripping.patch"
#)

src_prepare() {
	eapply_user
#	sed -i -e "s/#_cmake_modify_IGNORE//g" CMakeLists.txt libs/simde/test/CMakeLists.txt
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
