# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 cmake

EGIT_REPO_URI="https://github.com/surge-synthesizer/monique-monosynth"
EGIT_COMMIT="c46ef9f2d57dde84a5a22a0e05ba93d61a024b7f"

DESCRIPTION="Open source synthesizer plug-in"
HOMEPAGE="https://github.com/surge-synthesizer/monique-monosynth"
LICENSE="GPL-3 MIT"
SLOT="0"
KEYWORDS="amd64"

CMAKE_BUILD_TYPE="Release"

DEPEND="
	media-libs/alsa-lib
	media-libs/freetype
	media-sound/jack2
	x11-libs/libXcursor
	x11-libs/libXinerama
	x11-libs/libXrandr
"
RDEPEND="${DEPEND}"
BDEPEND="
"

src_install() {
	dodir /usr/lib64/vst3
	cp -a ${BUILD_DIR}/MoniqueMonosynth_artefacts/Release/VST3/MoniqueMonosynth.vst3 ${D}/usr/lib64/vst3/
	cp -a ${BUILD_DIR}/libs/oddsound-mts/liboddsound-mts.so ${D}/usr/lib64/
}
