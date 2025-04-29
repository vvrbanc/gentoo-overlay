# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 cmake

EGIT_REPO_URI="https://github.com/surge-synthesizer/surge.git"
EGIT_BRANCH="release-xt/1.3.4"
EGIT_COMMIT="1a247f8eeaf7bea33acccf89d8d841608c637f1b"

DESCRIPTION="Open source synthesizer plug-in"
HOMEPAGE="https://surge-synthesizer.github.io/"
LICENSE="GPL-3"
SLOT="0"
IUSE="-standalone -resources"
KEYWORDS="amd64"

CXXFLAGS="${CXXFLAGS} -mno-avx2"

DEPEND="
	media-libs/alsa-lib
	media-libs/freetype
	x11-libs/libXcursor
	x11-libs/libXinerama
	x11-libs/libXrandr
	media-sound/jack2
"
RDEPEND="${DEPEND}"

src_configure() {
	cd ${BUILD_DIR}
	cmake ${S} -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr -G Ninja
}

src_install() {
	debug-print-function ${FUNCNAME} "$@"
	_cmake_check_build_dir
	pushd "${BUILD_DIR}" > /dev/null || die
	DESTDIR="${D}" ${CMAKE_MAKEFILE_GENERATOR} install "$@" || die "died running ${CMAKE_MAKEFILE_GENERATOR} install"
	use resources || rm -rf ${D}/usr/share
	use standalone || rm -rf ${D}/usr/bin
}
